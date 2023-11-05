extends CharacterBody2D

var direction = 1
const SPEED = 300

func _ready():
	velocity.x = SPEED * direction
	# TWEENING CODE BELOW THROWING CONSOLE ERRORS
	#var TW1 = get_tree().create_tween()
	#var TW2 = get_tree().create_tween()
	#TW1.set_loops(0)
	#TW1.tween_property($Explode, "modulate:a", 
	#0.1, 0.5) #.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	#TW1.tween_property($Explode, "modulate:a", 
	#1.0, 0.5) #.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	#TW2.set_loops(0)	
	#TW2.tween_property($Explode, "position", position - Vector2(randf_range(-1, -8),randf_range(-10, 10)), 0.5)
	# TWEENING CODE ABOVE THROWING CONSOLE ERRORS

func _physics_process(_delta):
	if direction == 1:
		$Lazor.flip_h = true
	else:
		$Lazor.flip_h = false
	$Glint.rotation_degrees += 5 * direction
	$Explode.rotation_degrees += randf_range(0, 360) * direction
	if is_on_wall() or velocity.x == 0:
		#print("On The Wall!")
		set_physics_process(false)
		$Lazor.hide()
		$Glint.hide()
		$Explode.show()
		explode()
	move_and_slide()

func explode():
	$PlasmaExplode.play()
	$Timer.start()

func _on_timer_timeout():
	queue_free()

func _on_screen_exit_screen_exited():
	queue_free()
