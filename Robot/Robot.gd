extends CharacterBody2D

#var health = 10 # not needed anymore as it's now in the global Game script
const SPEED = 200.0
const JUMP_VELOCITY = -450.0
const DOUBLE_JUMP_VELOCITY = -450.0
const LAUNCH_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped = false
var is_launching = false
var is_falling = false
var is_shooting = false
var normal_modulation = Color(1, 1, 1)
var red_modulation = Color(0.81960785388947, 0.10196078568697, 0)
var invincibility = false

@onready var anim = get_node("AnimationPlayer")
@onready var coyote_jump_timer = $CoyoteJumpTimer

func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jumped = false
		is_launching = false
		is_falling = false

	# Handle Jump.
	if Game.JUMP:
		if is_on_floor() or coyote_jump_timer.time_left > 0.0:
			#created custom input keys
			#if Input.is_action_just_pressed("ui_accept"):
			if Input.is_action_just_pressed("jump"):
				$SoundJump.play()
				velocity.y = JUMP_VELOCITY
				anim.play("Jump")
				$RobotPoof.emitting = false
		elif not has_double_jumped:
			#Do a double jump
			if Game.DOUBLEJUMP:
				#created custom input keys
				#if Input.is_action_just_pressed("ui_accept"):
				if Input.is_action_just_pressed("jump"):
					$SoundJump.play()
					$RobotPoof.emitting = false
					#var TW1 = get_tree().create_tween()
					#TW1.tween_interval(5)
					#TW1.tween_property($Sprite2D, "visible", 
					#true, 0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
					#TW1.tween_property($Sprite2D, "position:y",
					#70.0, 0.8).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
					#TW1.tween_property($Sprite2D, "position", position - $Robot.get_node(position.x), 0.8)
					#TW1.tween_interval(0.25)
					#TW1.tween_property($Sprite2D, "visible", 
					#false, 0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
					velocity.y = DOUBLE_JUMP_VELOCITY
					anim.play("Jump")
					has_double_jumped = true

	# Handle Launching.
	if Game.LAUNCH:
		if Input.is_action_pressed("launch"):
			#if is_on_floor():
			is_launching = true
			if not is_falling:
				velocity.y = LAUNCH_VELOCITY
				anim.play("Launch")
				$RobotPoof.emitting = false
		if Input.is_action_just_released("launch"):
			is_launching = false
			is_falling = true
			if is_falling == true:
				#velocity.y = JUMP_VELOCITY + 5 # This is working bus causing mid-air launching
				pass
			else:
				velocity.y = JUMP_VELOCITY * 0.00001 # This is apparently not doing anything
				anim.play("Fall")
				$RobotPoof.emitting = false

	# Handle Shooting.
	if Game.GUN:
		if Input.is_action_pressed("shoot"):
			#if is_on_floor():
			#print("SHOOTING!!!!")
			is_shooting = true
			anim.play("Shoot")
			#else:
			#	pass
		else:
			is_shooting = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#created custom input keys
	#var direction = Input.get_axis("ui_left", "ui_right") 
	var direction = Input.get_axis("left", "right")
	
	# Handle movement.
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
		$RobotPoof.position.x = 25
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
		$RobotPoof.position.x = -25
	if direction:
		if is_launching:
			velocity.x = direction * SPEED / 5
		else:
			velocity.x = direction * SPEED
			if velocity.y == 0 and is_shooting != true:
				anim.play("Run")
				$RobotPoof.emitting = true
	else:
		if velocity.y == 0 and is_shooting != true:
			anim.play("Idle")
			$RobotPoof.emitting = false
			modulate = Color(1, 1, 1)
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.y > 0:
		anim.play("Fall")
		modulate = Color(0.81960785388947, 0.10196078568697, 0)
		$RobotPoof.emitting = false
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()
	
	if velocity.x == 0:
		$RobotPoof.emitting = false
	#if health <= 0: # not needed anymore as it's now in the global Game script
	#if Game.robotHP <= 0:
	#	queue_free()
	#	get_tree().change_scene_to_file("res://main.tscn")

func damage_modulation():
	$AnimatedSprite2D.modulate = Color(0.81960785388947, 0.10196078568697, 0)
	await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.modulate = Color(0.81960785388947, 0.10196078568697, 0)

func taking_damage():
	if $DamageCooldownTimddder.is_stopped():
		$DamageCooldownTimer.start()
		if invincibility == false:
			invincibility = true
			# Add losing a life/heart
			Game.robotHP -= 1
			$Sounds/TakingDamage.play()
			var TW1 = get_tree().create_tween()
			TW1.set_loops(10)
			TW1.tween_property($AllSprites, "modulate", 
			Color.RED, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
			TW1.tween_property($AllSprites, "modulate", 
			Color.WHITE, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	else:
		if invincibility == false:
			invincibility = true
			# Add losing a life/heart
			Game.robotHP -= 1
			$Sounds/TakingDamage.play()
			var TW1 = get_tree().create_tween()
			TW1.set_loops(10)
			TW1.tween_property($AllSprites, "modulate", 
			Color.RED, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
			TW1.tween_property($AllSprites, "modulate", 
			Color.WHITE, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))
