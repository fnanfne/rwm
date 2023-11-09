extends StaticBody2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("Robots"):
		body.gooped(0)
		#emit_signal("bottom")

func _on_area_2d_2_body_entered(body):
	if body.is_in_group("Robots"):
		body.gooped(1)
		#emit_signal("top")

func _on_area_2d_3_body_entered(body):
	if body.is_in_group("Robots"):
		body.gooped(2)

func _on_area_2d_4_body_entered(body):
	if body.is_in_group("Robots"):
		body.gooped(3)
