extends Area2D

@export var link_code : int
signal sad_happy(door)

func _ready():
	play_randomized("sad")

func play_randomized(sad : String):
	randomize()
	$AnimationPlayer.play(sad)
	var offset : float = randf_range(0, $AnimationPlayer.current_animation_length)
	$AnimationPlayer.advance(offset)

func _on_body_entered(body):
		if body.is_in_group("Robots"):
			#sad_happy()
			$Case/Sad.hide()
			$Case/SadBlink.hide()
			$AnimationPlayer.play("happy")
			#yield($AnimationPlayer, "animation_finished")
			$SadHappy.play()
			$CollisionShape2D.queue_free()
			emit_signal("sad_happy", link_code)

func _on_sad_happy():
	#$AnimationPlayer.play("happy")
	pass
