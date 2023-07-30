extends CharacterBody2D

enum States {FALL = 1, FLOOR, LAUNCH, ZOOM, SHOOT} # default numbering from 0, making air = 1 starts the numbering from one
var state = States.FALL

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
var is_jumping = false

@onready var anim = get_node("AnimationPlayer")
@onready var coyote_jump_timer = $CoyoteJumpTimer

@onready var anim_wheel = get_node("AllSprites/Wheel")
@onready var anim_idle = get_node("AllSprites/Idle")
@onready var anim_jump = get_node("AllSprites/Jump")
@onready var anim_fall = get_node("AllSprites/Fall")
@onready var anim_run = get_node("AllSprites/Run")
@onready var anim_shoot = get_node("AllSprites/Shoot")

func _physics_process(delta):
	#print(state)
	#print(Game.DOUBLEJUMP)
	#print(has_double_jumped)
	#print(is_jumping)
	# Coyote Jump
	var was_on_floor = is_on_floor()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()
	
	var direction = Input.get_axis("left", "right")	

	match state:
		States.FALL:
			if is_on_floor():
				state = States.FLOOR
			if velocity.y > 0:
				anim_jump.visible = false
				anim_wheel.visible = false
				anim_shoot.visible = false
				anim_idle.visible = false
				anim_run.visible = false
				anim_fall.visible = true
				is_jumping = false
				#has_double_jumped = false # Using this here causes infinite jumps
				####anim.play("Fall") # Not needed anymore because of all the booleans?
				$RobotPoof.emitting = false
			# Add Gravity.
			if not is_on_floor():
				velocity.y += gravity * delta
			else:
				has_double_jumped = false
				is_launching = false
				is_falling = false
				is_jumping = false
			# Handle Direction:
			if direction == -1:
				anim_wheel.visible = false
				anim_shoot.visible = false
				if is_jumping == true or has_double_jumped == true and velocity.y < 0:
					anim_fall.visible = false
				else:
					anim_fall.visible = true
				anim_idle.visible = false
				anim_run.visible = false
				anim_idle.flip_h = false
				anim_run.flip_h = false
				anim_wheel.flip_h = false
				anim_fall.flip_h = false
				anim_shoot.flip_h = false
				anim_jump.flip_h = false
				#$RobotPoof.position.x = 10
			elif direction == 1:
				anim_wheel.visible = false
				anim_shoot.visible = false
				if is_jumping == true or has_double_jumped == true and velocity.y < 0:
					anim_fall.visible = false
				else:
					anim_fall.visible = true
				anim_idle.visible = false
				anim_run.visible = false
				anim_idle.flip_h = true
				anim_run.flip_h = true
				anim_wheel.flip_h = true
				anim_fall.flip_h = true
				anim_shoot.flip_h = true
				anim_jump.flip_h = true
				#$RobotPoof.position.x = -10
			# Handle Double Jump
			if Game.JUMP:
				if coyote_jump_timer.time_left > 0.0:
					if Input.is_action_just_pressed("jump"):
						$Sounds/SoundJump.play()
						state = States.FALL # Should change to States.JUMP?
						velocity.y = JUMP_VELOCITY
						anim_run.visible = false
						anim_idle.visible = false
						anim_wheel.visible = false
						anim_jump.visible = true
						####anim.play("Jump") # Not needed anymore because of all the booleans?
						$RobotPoof.emitting = false
				elif not has_double_jumped:
					#Do a double jump
					if Game.DOUBLEJUMP:
						if Input.is_action_just_pressed("jump"):
							#state = States.FALL # Should change to States.JUMP?
							$Sounds/SoundJump.play()
							$RobotPoof.emitting = false
							velocity.y = DOUBLE_JUMP_VELOCITY
							anim_run.visible = false
							anim_idle.visible = false
							anim_wheel.visible = false
							anim_fall.visible = false
							anim_jump.visible = true
							####anim.play("Jump") # Not needed anymore because of all the booleans?
							has_double_jumped = true
			handle_left_right_direction()
			move_and_slide()

		States.FLOOR:
			if  not is_on_floor():
				state = States.FALL
			anim.play("Idle")
			# Add Gravity.
			if not is_on_floor():
				velocity.y += gravity * delta
				anim.play("Run")
			else:
				has_double_jumped = false
				is_launching = false
				is_falling = false
				is_jumping = false
			# Handle Direction:
			if direction == -1:
				anim_wheel.visible = true
				anim_idle.visible = false
				anim_shoot.visible = false
				anim_fall.visible = false
				anim.play("Run") # NOT WORKING!
				anim_run.visible = true
				anim_idle.flip_h = false
				anim_run.flip_h = false
				anim_wheel.flip_h = false
				anim_fall.flip_h = false
				anim_shoot.flip_h = false
				anim_jump.flip_h = false
				$RobotPoof.position.x = 10
			elif direction == 1:
				anim_wheel.visible = true
				anim_idle.visible = false
				anim_shoot.visible = false
				anim_fall.visible = false
				anim.play("Run") # NOT WORKING!
				anim_run.visible = true
				anim_idle.flip_h = true
				anim_run.flip_h = true
				anim_wheel.flip_h = true
				anim_fall.flip_h = true
				anim_shoot.flip_h = true
				anim_jump.flip_h = true
				$RobotPoof.position.x = -10
			# Check Robot Poof
			if velocity.x == 0:
				$RobotPoof.emitting = false
			# Handle Jump.
			if Game.JUMP:
				if not has_double_jumped or coyote_jump_timer.time_left > 0.0:
					if Input.is_action_just_pressed("jump"):
						is_jumping = true
						$Sounds/SoundJump.play()
						state = States.FALL # Should change to States.JUMP?
						velocity.y = JUMP_VELOCITY
						anim_run.visible = false
						anim_idle.visible = false
						anim_wheel.visible = false
						anim_jump.visible = true
						####anim.play("Jump") # Not needed anymore because of all the booleans?
						$RobotPoof.emitting = false
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
					print("SHOOTING!!!!")
					is_shooting = true
					anim_shoot.visible = true
					anim_idle.visible = false
					anim_wheel.visible = false
					#anim_idle.visible = false
					#anim_idle.visible = false
					####anim.play("Shoot") # Not needed anymore because of all the booleans?
					#else:
					#	pass
				else:
					is_shooting = false

### STATE MACHINE ABOVE ###

			handle_left_right_direction()
			move_and_slide()

func damage_modulation():
	$AnimatedSprite2D.modulate = Color(0.81960785388947, 0.10196078568697, 0)
	await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.modulate = Color(0.81960785388947, 0.10196078568697, 0)

func damaged():
	Game.lose_life()
	set_modulate(Color(1,0.3,0.3,0.3))
	$DamageTimer.start()
	
func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))

func handle_left_right_direction():
	var direction = Input.get_axis("left", "right")
	if direction:
		if is_launching:
			velocity.x = direction * SPEED / 5
		else:
			velocity.x = direction * SPEED
			###########anim_run.visible = false
			if velocity.y == 0 and is_shooting != true:
				anim.play("Run")
				$RobotPoof.emitting = true
	else:
		if velocity.y == 0 and is_shooting != true:
			anim_wheel.visible = true
			anim_idle.visible = true
			anim_shoot.visible = false
			anim_jump.visible = false
			anim_run.visible = false
			anim_fall.visible = false
			###anim.play("Idle") # Not needed anymore because of all the booleans?
			$RobotPoof.emitting = false
		velocity.x = move_toward(velocity.x, 0, SPEED)
