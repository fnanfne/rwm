extends StaticBody2D

@export var link_code : int

func _ready():
	#get_node().connect("sad_happy", self, "open_door")
	pass

func open_door():
	queue_free()

# DO THIS WHEN BOSS DIES
func _on_gun_target_body_entered(body):
	#$Timer.start()
	pass

func _on_timer_timeout():
	set_collision_layer_value(1,false)
	$OpenDoor.play()
	var TW1 = get_tree().create_tween()
	var TW2 = get_tree().create_tween()
	TW2.tween_property(self, "position", position - Vector2(0,40), 0.3)
	TW1.tween_property(self, "modulate:a", 0, 1.0)
	TW1.tween_callback(queue_free)

func _on_gun_target_2_body_entered(body):
	if body.is_in_group("Lazor"):
		$Timer.start()

func _on_gun_target_3_body_entered(body):
	if body.is_in_group("Lazor"):
		$Timer.start()
