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

@onready var anim = get_node("AnimationPlayer")
@onready var coyote_jump_timer = $CoyoteJumpTimer

func _physics_process(delta):
	print(is_falling)
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
				velocity.y = JUMP_VELOCITY
				anim.play("Jump")
		elif not has_double_jumped:
			#Do a double jump
			if Game.DOUBLEJUMP:
				#created custom input keys
				#if Input.is_action_just_pressed("ui_accept"):
				if Input.is_action_just_pressed("jump"):
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
		if Input.is_action_just_released("launch"):
			is_launching = false
			is_falling = true
			if is_falling == true:
				pass
			else:
				velocity.y = JUMP_VELOCITY
				anim.play("Fall")
			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#created custom input keys
	#var direction = Input.get_axis("ui_left", "ui_right") 
	var direction = Input.get_axis("left", "right")
	
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		if velocity.y == 0:
			anim.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.y > 0:
		anim.play("Fall")
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()
		
	#if health <= 0: # not needed anymore as it's now in the global Game script
	if Game.robotHP <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
