extends StaticBody2D




func _on_area_2d_body_entered(body):
	if body.is_in_group("Robots"):
		#$Gooped.play()
		#await $Gooped.finished
		#var TW1 = body.create_tween()
		#var TW2 = body.create_tween()
		#TW1.tween_property(self, "position", position - Vector2(0,-50), 0.5)
		#TW2.tween_property(self, "modulate:a", 0, 0.5)
		#TW1.tween_callback(queue_free)
		body.gooped()
