extends CharacterBody2D
class_name Robot
enum States {FALL = 1, FLOOR, LAUNCH, ZOOM, SHOOT, AUTO} # default numbering from 0, making air = 1 starts the numbering from one
var state = States.FALL

#var health = 10 # not needed anymore as it's now in the global Game script
const SPEED = 200.0
const RUNSPEED = 400.0
const JUMP_VELOCITY = -450.0
const DOUBLE_JUMP_VELOCITY = -450.0
const ZOOM_VELOCITY = 600.0
const LAUNCH_VELOCITY = -800.0
const PLASMABALL = preload("res://Scenes/plasmaball.tscn")
const LAZOR = preload("res://Scenes/lazor.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped = false
var is_launching = false
var is_zooming = false
var is_falling = false
var is_shooting = false
var is_jumping = false
var invincibility = false
var neuter_shooting = false
var is_alive = true
var is_autobot = false
var jump_pitch = 1.0
var zoom_minimum = Vector2(1.5001, 1.5001)
var zoom_maximum = Vector2(2.5001, 2.5001)
var zoom_speed = Vector2(0.1001, 0.1001)
var orientation = 1
var being_gooped = false

@export var robot_death_effect : PackedScene
#@export var starting_position : = Vector2 (20,50)
#@export var starting_position : = Vector2 Game.starting_position

@onready var anim = get_node("AnimationPlayer")
@onready var coyote_jump_timer = $Timers/CoyoteJumpTimer
@onready var shooting_cooldown_timer = $Timers/ShootingCooldownTimer
@onready var damage_cooldown_timer = $Timers/DamageCooldownTimer
@onready var camera = $Camera2D
@onready var sound_jump = $Sounds/SoundJump
@onready var push_speed = 125.0

@onready var anim_wheel = get_node("AllSprites/Wheel")
@onready var anim_idle = get_node("AllSprites/Idle")
@onready var anim_jump = get_node("AllSprites/Jump")
@onready var anim_fall = get_node("AllSprites/Fall")
@onready var anim_run = get_node("AllSprites/Run")
@onready var anim_shoot = get_node("AllSprites/Shoot")
@onready var anim_air_shoot = get_node("AllSprites/AirShoot")
@onready var anim_launch = get_node("AllSprites/Launch")
@onready var anim_launchfire = get_node("AllSprites/LaunchFire")
@onready var anim_helmet_idle = get_node("AllSprites/HelmetIdle")
@onready var anim_helmet_run = get_node("AllSprites/HelmetRun")
@onready var anim_helmet_jump = get_node("AllSprites/HelmetJump")
@onready var anim_helmet_launch = get_node("AllSprites/HelmetLaunch")
@onready var anim_helmet_idle_shoot = get_node("AllSprites/HelmetIdleShoot")
@onready var anim_helmet_fall = get_node("AllSprites/HelmetFall")
@onready var anim_zoomfire = get_node("AllSprites/ZoomFire")

#@onready var all_sprites_nodes = $AllSprites.get_children() # I tried creating a function instead.

# FUCK FUCK FUCK FUCK FUCK

func _ready():
	Game.Robot = self
	#position.x = Game.xPos
	#position.y = Game.yPos

func _physics_process(delta):
	#print(anim.current_animation)
	#print($DamageCooldownTimer.time_left)
	#print(invincibility)
	#print(Game.healthContainers)
	#print(Game.$AllSprites/ZoomFire)
	#print(orientation)
	#print($AllSprites/ZoomFire.flip_h)
	#print($Timers/LaunchTimer.time_left)
	#print($Timers/ZoomTimer.time_left)
	#print(Game.Robot.launch_timer_remaining)
	#print(gravity)
	#print($".".get_z_index())
	#print(jump_pitch)
	#print(Game.camera.position_smoothing_enabled)

	## Coyote Jump
	#var was_on_floor = is_on_floor()
	#var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	#if just_left_ledge:
	#	coyote_jump_timer.start()
	#	print("just_left_ledge")
	
	var direction = Input.get_axis("left", "right")

	if anim_idle.flip_h == true:
		orientation = 1
		#$AllSprites/ZoomFire.flip_h = true
	else:
		orientation = -1
		#$AllSprites/ZoomFire.flip_h = false

	match state:
		States.FALL:

			# FALL STATE CHECKER
			if is_on_floor():
				if is_autobot:
					state = States.AUTO
				else:
					$RobotLandPoofRight.emitting = true
					$RobotLandPoofLeft.emitting = true
					state = States.FLOOR

			# FALLING FROM FALL
			if velocity.y > 0:
				make_all_sprites_invisible()
				if is_shooting:
					anim_air_shoot.visible = true
				else:
					if Game.HEMLET and not is_on_floor():
						anim_fall.visible = true
						anim_helmet_fall.visible = true
					else:
						if is_alive:
							anim_fall.visible = true
						else:
							anim_idle.visible = true
							anim_wheel.visible = true
				is_jumping = false
				$RobotLandPoofRight.emitting = false
				$RobotLandPoofLeft.emitting = false
				$RobotPoof.emitting = false
				$RobotSparks.emitting = false

			# JUMPING FROM FALL
			if velocity.y < 0:
				make_all_sprites_invisible()
				if is_shooting:
					anim_air_shoot.visible = true
				else:
					if Game.HEMLET:
						anim_jump.visible = true
						anim_helmet_jump.visible = true
					else:
						anim_jump.visible = true
				is_jumping = false
				$RobotLandPoofRight.emitting = false
				$RobotLandPoofLeft.emitting = false
				$RobotPoof.emitting = false
				$RobotSparks.emitting = false

			# GRAVITY FROM FALL
			if not is_on_floor():
				velocity.y += gravity * delta
			else:
				has_double_jumped = false
				is_launching = false
				is_falling = false
				is_jumping = false

			# HANDLE DIRECTION FROM FALL:
			if direction == -1:
				$AllSprites/ZoomFire.position.x = 10
				make_sprites_fliph_false()

			elif direction == 1:
				$AllSprites/ZoomFire.position.x = -10
				make_sprites_fliph_true()

			# DOUBLE JUMP FROM FALL
			if Game.JUMP and is_alive == true:
				if not has_double_jumped:
					#Do a double jump
					if Game.DOUBLEJUMP and is_alive == true:
						if Input.is_action_just_pressed("jump"):
							#state = States.FALL # Should change to States.JUMP?
							#sound_jump.set_pitch_scale(jump_pitch)
							sound_jump.set_pitch_scale(1.2)
							sound_jump.play()
							#jump_pitch += 0.2
							$RobotPoof.emitting = false
							velocity.y = DOUBLE_JUMP_VELOCITY
							#print("Double Jumping UNDER FALL")
							has_double_jumped = true

			# LEFT/RIGHT MOVEMENT FROM FALL
			if direction and is_alive == true:
				if is_launching:
					velocity.x = direction * SPEED / 5
				else:
					if Input.is_action_pressed("run"):
						velocity.x = direction * SPEED * 1.2
					else:
						velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)

			# ZOOMING FROM FALL
			if Game.ZOOM and is_alive == true:# and not Input.is_action_pressed("zoom"):
				if Input.is_action_pressed("zoom"):
					$Timers/ZoomTimer.start()
					$Sounds/SoundLaunch.play()
					state = States.ZOOM

			# SHOOTING FROM FALL
			shoot_lazor()

			move_and_slide()


		States.FLOOR:

			# FLOOR VARIABLES
			if  1 == 1:
				has_double_jumped = false
				is_launching = false
				is_falling = false
				is_jumping = false
				anim_fall.visible = false
				anim_helmet_fall.visible = false
				jump_pitch = 1.0

			# STATE CHECKER FROM FLOOR
			
			if not is_on_floor():
				if not is_launching or not is_zooming:
					if coyote_jump_timer.time_left == 0.0:
						state = States.FALL

			# HANDLE DIRECTION FROM FLOOR:
			if direction == -1:
				make_all_sprites_invisible()
				if Game.HEMLET:
					anim.play("Helmet_Run")
					anim_helmet_run.visible = true
					anim_helmet_idle.visible = false
				else:
					anim.play("Run")
					anim_helmet_run.visible = false
				anim_run.visible = true
				anim_wheel.visible = true
				make_sprites_fliph_false()
				$AllSprites/ZoomFire.position.x = 10
				$RobotSparks.position.x = 7
				$RobotSparks.rotation = 50
				$RobotPoof.position.x = 10
				$Area2D2.rotation = 0
			elif direction == 1:
				make_all_sprites_invisible()
				if Game.HEMLET:
					anim.play("Helmet_Run")
					anim_helmet_run.visible = true
					anim_helmet_idle.visible = false
				else:
					anim.play("Run")
				anim_run.visible = true
				anim_wheel.visible = true
				make_sprites_fliph_true()
				$AllSprites/ZoomFire.position.x = -10
				$RobotSparks.position.x = -7
				$RobotSparks.rotation = 60 # 60 works nice
				$RobotPoof.position.x = -10
				$Area2D2.rotation = 3.1415

			# STANDING STILL FROM FLOOR
			if velocity.x == 0:
				if is_on_wall() and direction:
					pass
				else:
					make_all_sprites_invisible()
				anim.set_speed_scale(1.0)
				$RobotLandPoofRight.emitting = false
				$RobotLandPoofLeft.emitting = false
				$RobotPoof.emitting = false
				$RobotSparks.emitting = false
				if Game.HEMLET and not direction:
					anim.play("Helmet_Idle")
					anim_helmet_idle.visible = true
				else:
					anim.play("Idle")
			else:
				anim_helmet_idle.visible = false

			# JUMPING FROM FLOOR
			if Game.JUMP and is_alive == true:
				if not has_double_jumped or coyote_jump_timer.time_left > 0.0:
					if Input.is_action_just_pressed("jump"):
						coyote_jump_timer.stop() ### This is to prevent jumping higher than normal
						is_jumping = true
						sound_jump.set_pitch_scale(1.0)
						sound_jump.play()
						#state = States.FALL # Should change to States.JUMP?
						velocity.y = JUMP_VELOCITY
						make_all_sprites_invisible()
						if is_shooting:
							anim_air_shoot.visible = true
						else:
							anim_jump.visible = true
						$RobotPoof.emitting = false
						$RobotSparks.emitting = false

			# LAUNCHING FROM FLOOR
			if Game.LAUNCH and is_alive == true:
				if Input.is_action_pressed("launch"):
					$Timers/LaunchTimer.start()
					$Sounds/SoundLaunch.play()
					state = States.LAUNCH

			# ZOOMING FROM FLOOR
			if Game.ZOOM and is_alive == true:
				if Input.is_action_pressed("zoom"):
					$Timers/ZoomTimer.start()
					$Timers/LaunchTimer.start()
					$Sounds/SoundLaunch.play()
					state = States.ZOOM

			# SHOOTING FROM FLOOR
			shoot_lazor()

			# LEFT/RIGHT MOVEMENT FROM FLOOR
			if direction and is_alive == true:
				if is_launching:
					velocity.x = direction * SPEED / 5
				else:
					if Input.is_action_pressed("run"): # NEW CODE
						anim.set_speed_scale(3.0)
						$RobotSparks.emitting = true
						velocity.x = direction * RUNSPEED # NEW CODE
					else: # NEW CODE
						anim.set_speed_scale(2.0)
						$RobotSparks.emitting = false
						velocity.x = direction * SPEED
					if velocity.y == 0 and is_shooting != true:
						$RobotPoof.emitting = true
			else:
				if velocity.y == 0 and is_shooting != true:
					anim_wheel.visible = true
					anim_idle.visible = true
				velocity.x = move_toward(velocity.x, 0, SPEED)

			# Coyote Jump FROM FLOOR
			var was_on_floor = is_on_floor()
			move_and_slide()
			var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
			if just_left_ledge:
				coyote_jump_timer.start()
				#print("just_left_ledge_from FLOOR")

			# PHYSICS BOX
			if get_slide_collision_count() > 0:
				check_box_collision()

		States.LAUNCH:
			
			# STATE CHECKER FROM LAUNCHING
			if is_falling:
				state = States.FALL
			if is_on_floor():
				state = States.FLOOR

			# WHEN BUMPING HEAD ON CEILING FROM LAUNCHING
			if is_on_ceiling():
				Input.action_release("launch")
				$Sounds/LaunchBump.play()
				is_launching = false
				velocity.y = 200

			# HANDLE DIRECTION FROM LAUNCHING:
			if direction == -1:
				make_sprites_fliph_false()

			elif direction == 1:
				make_sprites_fliph_true()

			# LEFT/RIGHT MOVEMENT FROM LAUNCHING
			if direction and is_alive == true:
				velocity.x = direction * SPEED / 5

			# HANDLE LAUNCHING FROM LAUNCHING
			if Game.LAUNCH and is_alive == true:
				if Input.is_action_pressed("launch"):
					is_launching = true
					$RobotPoof.emitting = false
					#state = States.LAUNCH
					if not is_falling:
						velocity.y = LAUNCH_VELOCITY
						make_all_sprites_invisible()
						if Game.HEMLET:
							anim_helmet_launch.visible = true
						anim_launchfire.visible = true
						anim_launch.visible = true
						anim.play("Launch")
				if Input.is_action_just_released("launch"):
					state = States.FALL

			move_and_slide()

		States.ZOOM:

######and not Input.is_action_pressed("zoom")#####

			# HANDLE DIRECTION FROM ZOOMING:
			if direction == -1:
				make_sprites_fliph_false()
			elif direction == 1:
				make_sprites_fliph_true()

			# LEFT/RIGHT MOVEMENT FROM ZOOMING
			#if direction and is_alive == true:
			#	velocity.x = direction * ZOOM_VELOCITY

			# HANDLE ZOOMING FROM ZOOMING
			if Game.ZOOM and is_alive == true:
				if Input.is_action_pressed("zoom"):
					is_zooming = true
					$RobotPoof.emitting = false
					velocity.x = ZOOM_VELOCITY * orientation
					velocity.y = -0.5
					make_all_sprites_invisible()
					if Game.HEMLET:
						anim_helmet_jump.visible = true
					anim_zoomfire.visible = true
					anim_jump.visible = true
					anim.play("Jump")
				if Input.is_action_just_released("zoom"):
					state = States.FALL

			move_and_slide()

		States.AUTO:
						
			# AUTOBOT VARIABLES
			if  1 == 1:
				has_double_jumped = false
				is_launching = false
				is_falling = false
				is_jumping = false

			# STATE CHECKER FROM AUTO 
			if  not is_autobot:
				state = States.FLOOR

			# HANDLE DIRECTION FROM AUTO:
			if direction == -1:
				make_all_sprites_invisible()
				anim_wheel.visible = true
				anim_idle.visible = true
				make_sprites_fliph_false()
				$Area2D2.rotation = 0
			elif direction == 1:
				make_all_sprites_invisible()
				anim_wheel.visible = true
				anim_idle.visible = true
				make_sprites_fliph_true()
				$Area2D2.rotation = 3.1415

			# STANDING STILL FROM AUTO
			if velocity.x == 0:
				anim.set_speed_scale(1.0)
				$RobotPoof.emitting = false
				anim.play("Idle")

			# JUMPING FROM AUTO
			if Game.JUMP and is_alive == true:
				pass

			# LAUNCHING FROM AUTO
			if Game.LAUNCH and is_alive == true:
				pass

			# SHOOTING FROM AUTO
			shoot_lazor()

			# LEFT/RIGHT MOVEMENT FROM AUTO
			if velocity.y == 0 and is_shooting != true:
				make_all_sprites_invisible()
				anim_wheel.visible = true
				anim_idle.visible = true
			velocity.x = move_toward(velocity.x, 0, SPEED)
			move_and_slide()

### FINITE STATE MACHINE ABOVE ###

func taking_damage():
	if Game.robotHP == 0:
		#Game.respawn()
		respawn()
	else:
		if $Timers/DamageCooldownTimer.is_stopped():
			$Timers/DamageCooldownTimer.start()
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

func respawn():
	Game.camera.position_smoothing_enabled = true
	Game.camera.position_smoothing_speed = 5
	Game.camera.shake(0.5, 10)
	get_node("Area2D/CollisionShape2D").set_deferred("disabled", true)
	$".".hide()
	var effect_instance : CPUParticles2D = robot_death_effect.instantiate()
	effect_instance.position = position
	effect_instance.emitting = true
	get_parent().add_child(effect_instance)
	is_alive = false
	#set_physics_process(false)
	#set_process_input(false)
	$Timers/RespawnTimer.start()
	$Sounds/Die.play()

func gooped(location):
	if being_gooped == true:
		pass
	else:
		being_gooped = true
		$".".set_z_index(-1)
		#get_node("CollisionPolygon2D").set_deferred("disabled", true)
		$Sounds/Gooped.play()
		#set_process_input(false)
		var TW1 = get_tree().create_tween()
		var TW2 = get_tree().create_tween()
		if location == 0:
			TW1.tween_property(self, "position", position - Vector2(-10,-20), 1)
		elif location == 1:
			TW1.tween_property(self, "position", position - Vector2(-10,20), 1)
		elif location == 2:
			TW1.tween_property(self, "position", position - Vector2(10,-20), 1)
		else:# location == 3:
			TW1.tween_property(self, "position", position - Vector2(10,20), 1)
		TW2.tween_property(self, "modulate", Color.RED, 1)
		is_alive = false
		await TW1.finished
		#set_physics_process(false)
		$".".hide()
		$Timers/RespawnTimer.start()
		#await $Sounds/Gooped.finished

func _on_respawn_timer_timeout():
	if Game.current_checkpoint != null:
		Game.Robot.position = Game.current_checkpoint.global_position
	else:
		Game.Robot.position = Game.starting_position
	being_gooped = false
	$Timers/MoveAfterRespawnTimer.start()
	#is_alive = true
	$".".set_z_index(4)
	#set_physics_process(true)
	$".".show()
	get_node("Area2D/CollisionShape2D").set_deferred("disabled", false)
	modulate = Color(Color.WHITE)


func _on_move_after_respawn_timer_timeout():
	is_alive = true
	$Timers/SmoothingCameraTimer.start()

func _on_smoothing_camera_timer_timeout():
	Game.camera.position_smoothing_enabled = false


func shoot_lazor():
	#if LAZOR:
	if Game.GUN:
		if Game.ANNIHILATE:
			$Timers/ShootingCooldownTimer.wait_time = 0.1
		else:
			$Timers/ShootingCooldownTimer.wait_time = 0.4
		if Input.is_action_pressed("shoot") and shooting_cooldown_timer.is_stopped() and not is_on_wall():
			var direction = -1 if anim_idle.flip_h else 1
			var f = LAZOR.instantiate()
			f.direction = direction * -1
			get_parent().add_child(f)
			f.position.y = position.y - 5
			f.position.x = position.x - 30 * direction
			# NEW TWEENING CODE BELOW MOVED FROM THE PROJECTILE ITSELF TO ADDRESS CONSOLE ERRORS
			# NEW TWEENING CODE ABOVE MOVED FROM THE PROJECTILE ITSELF TO ADDRESS CONSOLE ERRORS
			fire_logic()
		elif Input.is_action_pressed("shoot2") and shooting_cooldown_timer.is_stopped() and not is_on_wall():
			var direction = -1 if anim_idle.flip_h else 1
			var f = PLASMABALL.instantiate()
			f.direction = direction * -1
			get_parent().add_child(f)
			f.position.y = position.y - 5
			f.position.x = position.x - 30 * direction
			# NEW TWEENING CODE BELOW MOVED FROM THE PROJECTILE ITSELF TO ADDRESS CONSOLE ERRORS
			# NEW TWEENING CODE ABOVE MOVED FROM THE PROJECTILE ITSELF TO ADDRESS CONSOLE ERRORS
			fire_logic()
		else:
			anim_air_shoot.visible = false # does this do anything?
			is_shooting = false

func fire_logic():
	$Sounds/GunFire.play()
	is_shooting = true
	# Checking if in the air
	if velocity.y != 0:
		anim_air_shoot.visible = true
	else:
		anim_air_shoot.visible = false
		if velocity.x != 0:
			anim_shoot.visible = false
		else:
			anim_shoot.visible = true
		# Checking if running on the ground
		if velocity.x != 0:
			pass
			#anim_idle.visible = false
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

func _on_area_2d_2_body_entered(body):
	if Game.GUN == true:
		if body.is_in_group("World"):
			neuter_shooting = true
			Game.GUN = false

func _on_area_2d_2_body_exited(body):
	if neuter_shooting == true:
		if body.is_in_group("World"):
			Game.GUN = true
			neuter_shooting = false

func _on_launch_timer_timeout():
	state = States.FALL
	has_double_jumped = true
	anim_launch.visible = false
	anim_launchfire.visible = false
	is_launching = false

func make_all_sprites_invisible():
	anim_wheel.visible = false
	anim_idle.visible = false
	anim_jump.visible = false
	anim_fall.visible = false
	anim_run.visible = false
	anim_shoot.visible = false
	anim_launchfire.visible = false
	anim_launch.visible = false
	anim_air_shoot.visible = false
	anim_helmet_idle.visible = false
	anim_helmet_run.visible = false
	anim_helmet_jump.visible = false
	anim_helmet_launch.visible = false
	anim_helmet_idle_shoot.visible = false
	anim_helmet_fall.visible = false
	anim_zoomfire.visible = false

func make_sprites_fliph_false():
	anim_wheel.flip_h = false
	anim_idle.flip_h = false
	anim_jump.flip_h = false
	anim_fall.flip_h = false
	anim_run.flip_h = false
	anim_shoot.flip_h = false
	anim_launchfire.flip_h = false
	anim_launch.flip_h = false
	anim_air_shoot.flip_h = false
	anim_helmet_idle.flip_h = false
	anim_helmet_run.flip_h = false
	anim_helmet_jump.flip_h = false
	anim_helmet_launch.flip_h = false
	anim_helmet_idle_shoot.flip_h = false
	anim_helmet_fall.flip_h = false
	anim_zoomfire.flip_h = false

func make_sprites_fliph_true():
	anim_wheel.flip_h = true
	anim_idle.flip_h = true
	anim_jump.flip_h = true
	anim_fall.flip_h = true
	anim_run.flip_h = true
	anim_shoot.flip_h = true
	anim_launchfire.flip_h = true
	anim_launch.flip_h = true
	anim_air_shoot.flip_h = true
	anim_helmet_idle.flip_h = true
	anim_helmet_run.flip_h = true
	anim_helmet_jump.flip_h = true
	anim_helmet_launch.flip_h = true
	anim_helmet_idle_shoot.flip_h = true
	anim_helmet_fall.flip_h = true
	anim_zoomfire.flip_h = true

# ZOOM SCREEN IN / OUT WITH MOUSEWHEEL
func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if camera.zoom > zoom_minimum:
					camera.zoom -= zoom_speed
					pass
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if camera.zoom < zoom_maximum:
					camera.zoom += zoom_speed
	pass

func _on_coyote_jump_timer_timeout():
	#print("Coyote Timer is up!!!")
	pass

func _on_zoom_timer_timeout():
	is_zooming = false
	state = States.FALL
	Input.action_release("zoom")

# PAUSE SCREEN
func _unhandled_input(_event: InputEvent):
	#if event.is_action_pressed("ui_cancel"):
	#	$PauseScreen.pause()
	pass
	
# PHYSICS BOX
func check_box_collision():
	#if abs(velocity.x) + abs(velocity.y) > 1:
	if velocity.y > 1:
		return
	var box : = get_slide_collision(0).get_collider() as Box
	if box:
		box.push(push_speed * velocity)
