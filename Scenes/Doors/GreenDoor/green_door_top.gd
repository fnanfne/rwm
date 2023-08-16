extends StaticBody2D

func _on_door_zone_body_entered(body):
	if Game.GREENKEY == true:
		#if body.name == "Robot":
		if body.is_in_group("Robots"):
			set_collision_mask_value(1,false)
			$OpenDoor.play()
			var tween1 = get_tree().create_tween()
			#var tween2 = get_tree().create_tween()
			tween1.tween_property(self, "position", position - Vector2(0,42), 0.8)
			#tween2.tween_property(self, "modulate:a", 0, 0.5)
			tween1.tween_callback(queue_free)
