extends StaticBody2D

@export var link_code : int


func open_door():
	queue_free()


func _on_computer_body_entered(body):
	if body.is_in_group("Robots"):
		if Game.HAXXOR == true:
			$Timer.start()


func _on_timer_timeout():
	#set_collision_mask_value(1,false) # NOT WORKING
	set_collision_layer_value(1,false)
	$DoorOpen.play()
	var TW1 = get_tree().create_tween()
	var TW2 = get_tree().create_tween()
	TW2.tween_property(self, "position", position - Vector2(0,80), 0.3)
	TW1.tween_property(self, "modulate:a", 0, 1.0)
	TW1.tween_callback(queue_free)


func _on_computer_2_body_entered(body):
	if body.is_in_group("Robots"):
		if Game.HAXXOR == true:
			#$Timer2.start()
			$Timer.start()


#func _on_timer_2_timeout():
#	$DoorOpen.play()
#	var TW1 = get_tree().create_tween()
#	var TW2 = get_tree().create_tween()
#	TW2.tween_property(self, "position", position - Vector2(0,50), 0.3)
#	TW1.tween_property(self, "modulate:a", 0, 1.0)
#	TW1.tween_callback(queue_free)


func _on_computer_3_body_entered(body):
	if body.is_in_group("Robots"):
		if Game.HAXXOR == true:
			#$Timer2.start()
			$Timer.start()
