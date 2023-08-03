extends CharacterBody2D

var direction = 1
const SPEED = 222
const GRAVITY = 0.5

func _ready():
	velocity.y = SPEED * direction
	var TW1 = get_tree().create_tween()
	TW1.set_loops(0)
	TW1.tween_property($Sprite2D, "rotation", 
	0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	TW1.tween_property($Sprite2D, "rotation", 
	-0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _physics_process(_delta):
	#print(velocity.y)
	velocity.y += GRAVITY

	if is_on_floor():
		set_physics_process(false)
		$Sprite2D.hide()
		explode()

	if $Sprite2D.visible == false:
		#$SlimeSplat.play()
		#print("WHAT BOUT NOW?!?!?!")
		pass

	move_and_slide()

func explode():
	$Timer.start()

func on_screen_exited():
	queue_free()

func _on_timer_timeout():
	#print("SPLAT?!!?!?!?")
	#$SlimeSplat.play()
	queue_free()
