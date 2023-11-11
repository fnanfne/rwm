extends Area2D

#var force = Vector2.RIGHT * -400

func _on_body_entered(body):
	if body.is_in_group("Robots"):
		body.velocity.y = -400
		$AudioStreamPlayer.play()
		zoing()

func _process(_delta):
	pass

func zoing():
	var TW1 = get_tree().create_tween()
	#TW1.set_loops(10)
	TW1.tween_property($SpringTop, "position", 
	Vector2(0, -15), 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	TW1.tween_property($SpringTop, "position", 
	Vector2(0, 0), 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
