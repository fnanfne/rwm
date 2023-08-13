extends StaticBody2D

@export var btc_required : int = 7

func _physics_process(_delta):
	if Game.BTC == btc_required:
		$Timer.start()

#func _on_computer_body_entered(body):
#	if body.is_in_group("Robots"):
#		$Timer.start()

func _on_timer_timeout():
	$CollisionShape2D.queue_free()
	$DoorOpen.play()
	var TW1 = get_tree().create_tween()
	var TW2 = get_tree().create_tween()
	TW2.tween_property(self, "position", position - Vector2(80,0), 0.3)
	TW1.tween_property(self, "modulate:a", 0, 1.0)
	TW1.tween_callback(queue_free)
