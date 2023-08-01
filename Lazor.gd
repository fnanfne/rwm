extends CharacterBody2D

var direction = 1
const SPEED = 300

func _ready():
	velocity.x = SPEED * direction
	#var TW1 = get_tree().create_tween()
	#TW1.set_loops(0)
	#TW1.tween_property($Sprite2D, "modulate",
	#Color(1,0,1,1),0.1)
	#TW1.tween_property($Sprite2D, "modulate",Color.WHITE,0.1)

func _physics_process(_delta):
	if direction == 1:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	$Sprite2D2.rotation_degrees += 5 * direction
	if is_on_wall():
		#print("On The Wall!")
		set_physics_process(false)
		$Sprite2D.hide()
		$Sprite2D2.hide()
		explode()
	move_and_slide()

func explode():
	$PlasmaExplode.play()
	$Timer.start()

func _on_timer_timeout():
	queue_free()
	#$PlasmaExplode.play()
	$Timer2.start()

func _on_screen_exit_screen_exited():
	queue_free()
