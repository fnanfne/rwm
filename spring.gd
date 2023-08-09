extends Area2D

#var force = Vector2.RIGHT * -400

func _on_body_entered(body):
	if body.is_in_group("Robots"):
		body.velocity.y = -400
		#body.velocity.y = velocity

func _process(_delta):
	pass
