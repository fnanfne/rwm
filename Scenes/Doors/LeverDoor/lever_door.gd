extends StaticBody2D

@export var lever_number : int = 0

#func _on_computer_body_entered(body):
#	if body.is_in_group("Robots"):
#		$Timer.start()

func _on_lever_lever_turned():
	$Timer.start()

func _on_timer_timeout():
	$Timer2.start()
	$Screetch.play()
	await $Screetch.finished
	$Explode.play()

func _on_timer_2_timeout():
	$CollisionShape2D.queue_free()
	$DoorOpen.play()
	var TW1 = get_tree().create_tween()
	var TW2 = get_tree().create_tween()
	TW2.tween_property(self, "position", position - Vector2(-80,0), 0.5)
	TW1.tween_property(self, "modulate:a", 0, 1.0)
	await $DoorOpen.finished
	TW1.tween_callback(queue_free)
