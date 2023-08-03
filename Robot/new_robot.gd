extends CharacterBody2D

enum States {FALL = 1, FLOOR, LAUNCH, ZOOM, SHOOT} # default numbering from 0, making air = 1 starts the numbering from one
var state = States.FALL

#var health = 10 # not needed anymore as it's now in the global Game script
const SPEED = 200.0
const RUNSPEED = 400.0
const JUMP_VELOCITY = -450.0
const DOUBLE_JUMP_VELOCITY = -450.0
const LAUNCH_VELOCITY = -800.0
const PLASMABALL = preload("res://Scenes/plasmaball.tscn")
const LAZOR = preload("res://Scenes/lazor.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped = false
var is_launching = false
var is_falling = false
var is_shooting = false
var is_jumping = false
var invincibility = false

@onready var anim = get_node("AnimationPlayer")
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var shooting_cooldown_timer = $ShootingCooldownTimer
@onready var damage_cooldown_timer = $DamageCooldownTimer

@onready var anim_wheel = get_node("AllSprites/Wheel")
@onready var anim_idle = get_node("AllSprites/Idle")
@onready var anim_jump = get_node("AllSprites/Jump")
@onready var anim_fall = get_node("AllSprites/Fall")
@onready var anim_run = get_node("AllSprites/Run")
@onready var anim_shoot = get_node("AllSprites/Shoot")
@onready var anim_air_shoot = get_node("AllSprites/AirShoot")
@onready var anim_launch = get_node("AllSprites/Launch")
@onready var anim_launchfire = get_node("AllSprites/LaunchFire")

func _physics_process(delta):
	
	#print($DamageCooldownTimer.time_left)
	print(invincibility)

	# Coyote Jump
	var was_on_floor = is_on_floor()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()
	
	var direction = Input.get_axis("left", "right")

	match state:
		States.FALL:

			# STATE CHECKER
			if is_on_floor():
				state = States.FLOOR

			if velocity.y > 0:
				anim_jump.visible = false
				anim_wheel.visible = false
				anim_shoot.visible = false
				anim_idle.visible = false
				anim_run.visible = false
				if is_shooting:
					anim_air_shoot.visible = true
				else:
					anim_fall.visible = true
				is_jumping = false
				$RobotPoof.emitting = false
				$RobotSparks.emitting = false

			# GRAVITY
			if not is_on_floor():
				velocity.y += gravity * delta
			else:
				has_double_jumped = false
				is_launching = false
				is_falling = false
				is_jumping = false

			# HANDLE DIRECTION:
			if direction == -1:
				anim_air_shoot.visible = false
				anim_shoot.visible = false
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
				anim_air_shoot.flip_h = false
				anim_shoot.flip_h = false
				#$RobotPoof.position.x = 10
			elif direction == 1:
				anim_air_shoot.visible = false
				anim_shoot.visible = false
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
				anim_air_shoot.flip_h = true
				anim_shoot.flip_h = true
				#$RobotPoof.position.x = -10

			# DOUBLE JUMP
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

			# LEFT/RIGHT MOVEMENT
			if direction:
				if is_launching:
					velocity.x = direction * SPEED / 5
				else:
					if Input.is_action_pressed("run"): # NEW CODE
						$RobotSparks.emitting = true
						velocity.x = direction * RUNSPEED # NEW CODE
					else: # NEW CODE
						$RobotSparks.emitting = false
						velocity.x = direction * SPEED
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
					anim_launch.visible = false
					anim_launchfire.visible = false
				velocity.x = move_toward(velocity.x, 0, SPEED)

			# SHOOTING
			shoot_lazor()

			move_and_slide()

		States.FLOOR:
			
			# ON FLOOR VARIABLES
			if  1 == 1:
				has_double_jumped = false
				is_launching = false
				is_falling = false
				is_jumping = false

			# STATE CHECKER.
			if  not is_on_floor():
				state = States.FALL

			# HANDLE DIRECTION:
			if direction == -1:
				anim_air_shoot.visible = false
				anim_shoot.visible = false
				anim_launch.visible = false
				anim_launchfire.visible = false
				anim_wheel.visible = true
				anim_idle.visible = false
				anim_shoot.visible = false
				anim_fall.visible = false
				anim_run.visible = true
				anim_idle.flip_h = false
				anim_run.flip_h = false
				anim_wheel.flip_h = false
				anim_fall.flip_h = false
				anim_shoot.flip_h = false
				anim_jump.flip_h = false
				anim_launch.flip_h = false
				anim_launchfire.flip_h = false
				anim_air_shoot.flip_h = false
				anim_shoot.flip_h = false
				$RobotSparks.position.x = 7
				$RobotSparks.rotation = 50
				$RobotPoof.position.x = 10
			elif direction == 1:
				anim_air_shoot.visible = false
				anim_shoot.visible = false
				anim_launch.visible = false
				anim_launchfire.visible = false
				anim_wheel.visible = true
				anim_idle.visible = false
				anim_shoot.visible = false
				anim_fall.visible = false
				anim_run.visible = true
				anim_idle.flip_h = true
				anim_run.flip_h = true
				anim_wheel.flip_h = true
				anim_fall.flip_h = true
				anim_shoot.flip_h = true
				anim_jump.flip_h = true
				anim_launch.flip_h = true
				anim_launchfire.flip_h = true
				anim_air_shoot.flip_h = true
				anim_shoot.flip_h = true
				$RobotSparks.position.x = -7
				$RobotSparks.rotation = 60 # 60 works nice
				$RobotPoof.position.x = -10

			# STANDING STILL
			if velocity.x == 0:
				anim_air_shoot.visible = false
				anim_shoot.visible = false
				$AnimationPlayer.set_speed_scale(1.0)
				$RobotPoof.emitting = false
				anim.play("Idle")

			# JUMPING
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
						if is_shooting:
							anim_air_shoot.visible = true
						else:
							anim_jump.visible = true
						$RobotPoof.emitting = false
						$RobotSparks.emitting = false

			# LAUNCHING
			if Game.LAUNCH:
				if Input.is_action_pressed("launch"):
					#if is_on_floor():
					is_launching = true
					if not is_falling:
						velocity.y = LAUNCH_VELOCITY
						
						anim_run.visible = false
						anim_idle.visible = false
						anim_wheel.visible = false
						anim_jump.visible = false
						
						anim.play("Launch")
						$RobotSparks.emitting = false
						$RobotPoof.emitting = false
				if Input.is_action_just_released("launch"):
					is_launching = false
					is_falling = true
					if is_falling == true:
						pass
					else:
						velocity.y = JUMP_VELOCITY * 0.00001 # This is apparently not doing anything
						anim.play("Fall")
						$RobotPoof.emitting = false
						$RobotSparks.emitting = false

			# SHOOTING
			shoot_lazor()

			# LEFT/RIGHT MOVEMENT
			if direction:
				if is_launching:
					velocity.x = direction * SPEED / 5
				else:
					if Input.is_action_pressed("run"): # NEW CODE
						$AnimationPlayer.set_speed_scale(3.0)
						$RobotSparks.emitting = true
						velocity.x = direction * RUNSPEED # NEW CODE
					else: # NEW CODE
						$AnimationPlayer.set_speed_scale(2.0)
						$RobotSparks.emitting = false
						velocity.x = direction * SPEED
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
					anim_launch.visible = false
					anim_launchfire.visible = false
				velocity.x = move_toward(velocity.x, 0, SPEED)

			move_and_slide()

### STATE MACHINE ABOVE ###

func taking_damage():
	if $DamageCooldownTimer.is_stopped():
		$DamageCooldownTimer.start()
		if invincibility == false:
			invincibility = true
			# Add losing a life/heart
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
			$Sounds/TakingDamage.play()
			var TW1 = get_tree().create_tween()
			TW1.set_loops(10)
			TW1.tween_property($AllSprites, "modulate", 
			Color.RED, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
			TW1.tween_property($AllSprites, "modulate", 
			Color.WHITE, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func shoot_lazor():
	#if LAZOR:
	if Game.GUN:
		if Game.ANNIHILATE:
			$ShootingCooldownTimer.wait_time = 0.1
		else:
			$ShootingCooldownTimer.wait_time = 0.4
		if Input.is_action_pressed("shoot") and shooting_cooldown_timer.is_stopped():
			var direction = -1 if anim_idle.flip_h else 1
			var f = LAZOR.instantiate()
			f.direction = direction * -1
			get_parent().add_child(f)
			f.position.y = position.y - 5
			f.position.x = position.x - 30 * direction
			fire_logic()
		elif Input.is_action_pressed("shoot2") and shooting_cooldown_timer.is_stopped():
			var direction = -1 if anim_idle.flip_h else 1
			var f = PLASMABALL.instantiate()
			f.direction = direction * -1
			get_parent().add_child(f)
			f.position.y = position.y - 5
			f.position.x = position.x - 30 * direction
			fire_logic()
		else:
			anim_air_shoot.visible = false
			is_shooting = false

func fire_logic():
	$Sounds/GunFire.play()
	is_shooting = true
	# Checking if in the air
	if velocity.y != 0:
		anim_air_shoot.visible = true
	else:
		anim_air_shoot.visible = false
		anim_shoot.visible = true
		# Checking if running on the ground
		if velocity.y == 0 and velocity.x != 0:
			anim_idle.visible = false
		else:
			pass
			#anim_run.visible = true
	anim_idle.visible = false
	anim_fall.visible = false
	shooting_cooldown_timer.start()


func _on_area_2d_body_entered(body):
	if body.is_in_group("EnemyProjectiles"):
		body.queue_free()
		taking_damage()

func _on_damage_cooldown_timer_timeout():
	invincibility = false
