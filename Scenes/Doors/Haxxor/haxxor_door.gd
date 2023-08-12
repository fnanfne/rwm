extends StaticBody2D

@export var link_code : int

func _ready():
	#get_node().connect("sad_happy", self, "open_door")
	pass
	

func open_door():
	queue_free()


func _on_computer_body_entered(body):
	$Timer.start()

func _on_timer_timeout():
	$CollisionShape2D.queue_free()
	$DoorOpen.play()
	var TW1 = get_tree().create_tween()
	var TW2 = get_tree().create_tween()
	TW2.tween_property(self, "position", position - Vector2(0,80), 0.3)
	TW1.tween_property(self, "modulate:a", 0, 1.0)
	TW1.tween_callback(queue_free)

func _on_computer_2_body_entered(body):
	$Timer2.start()

func _on_timer2_timeout():
	$CollisionShape2D.queue_free()
	$DoorOpen.play()
	var TW1 = get_tree().create_tween()
	var TW2 = get_tree().create_tween()
	TW2.tween_property(self, "position", position - Vector2(0,50), 0.3)
	TW1.tween_property(self, "modulate:a", 0, 1.0)
	TW1.tween_callback(queue_free)
