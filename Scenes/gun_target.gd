extends Area2D

@export var link_code : int
signal activated(door)

func _on_body_entered(body):
	if body.is_in_group("Lazor"):
		$CollisionShape2D.queue_free()
		$AnimationPlayer.play("Used")
		$AnimationPlayer.stop()
		$Box/Icon.hide()
		$Activated.play()
		emit_signal("activated", link_code)

####
