extends StaticBody2D


func _on_area_2d_body_entered(body):
	if body.is_in_group("Robots"):
		body.set_z_index(-1)
		#print("SPIKE DAMAGE!!")
		body.respawn()
