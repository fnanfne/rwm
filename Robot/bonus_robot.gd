extends CharacterBody2D

@export var gravity = 1600
@export var jump_power = -450

@onready var anim = get_node("AnimationPlayer")
@onready var wheel = $AllSprites/Wheel
@onready var body = $AllSprites/Body
@onready var jump = $AllSprites/Jump
@onready var fall = $AllSprites/Fall

#@onready var sprite = $AnimatedSprite2D
@onready var jump_sound = $SoundJump
@onready var camera = $/root/BonusLevel/Camera2D
#@onready var camera = $/root/TestLevel/Camera2D

var active = true
var jumps_remaining = 2
var was_jumping = false
var jump_pitch = 1.0

func _ready():
	pass
	#anim.play("run")
	#hide_all_sprites()
	#wheel.visible = true
	#body.visible = true
	#Input.action_press("jump")
#	
	#Input.action_release("jump")
	
func _physics_process(delta):
	#print(velocity.y)
	#print(jumps_remaining)
	velocity.y += gravity * delta
	
	if active:
		# Update the camera position
		camera.position = position
		
		# Reset the player after landing
		if was_jumping and is_on_floor():
			was_jumping = false
			jumps_remaining = 2
			anim.play("run")
			hide_all_sprites()
			wheel.visible = true
			body.visible = true
			jump_pitch = 1.0
		
		# Handle jumping
		if Input.is_action_just_pressed("jump") and jumps_remaining > 0:
			jumps_remaining -= 1
			was_jumping = true
			velocity.y = jump_power
			hide_all_sprites()
			jump.visible = true
			
			if jumps_remaining == 1:
				jump.visible = true 

			jump_sound.set_pitch_scale(jump_pitch)
			jump_sound.play()
			jump_pitch += 0.2
	
	move_and_slide()

		# ON THE FLOOR
	if is_on_floor():
		hide_all_sprites()
		wheel.visible = true
		body.visible = true

		# FALLING
	if velocity.y > 0:
		hide_all_sprites()
		fall.visible = true

func hide_all_sprites():
	wheel.visible = false
	body.visible = false
	jump.visible = false
	fall.visible = false
