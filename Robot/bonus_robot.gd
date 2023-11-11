extends CharacterBody2D

signal robot_died

const PLASMABALL = preload("res://Scenes/plasmaball.tscn")

@export var gravity = 1400 #1600
@export var jump_power = -500 #-450
@export var robot_death_effect : PackedScene

@onready var anim = get_node("AnimationPlayer")
@onready var wheel = $AllSprites/Wheel
@onready var body = $AllSprites/Body
@onready var jump = $AllSprites/Jump
@onready var fall = $AllSprites/Fall
@onready var shooting_cooldown_timer = $ShootingCooldownTimer
@onready var anim_shoot = get_node("AllSprites/Shoot")

#@onready var sprite = $AnimatedSprite2D
@onready var jump_sound = $SoundJump
@onready var camera = $/root/BonusLevel/Camera2D
#@onready var camera = $/root/TestLevel/Camera2D

@onready var top_note = $NotesMessages/Areas/TopMarginContainer/Label
@onready var bottom_note = $NotesMessages/Areas/BottomMarginContainer/Label
@onready var app_anim = get_node("NotesMessages/AppAnimationPlayer")

var active = true
var jumps_remaining = 2
var was_jumping = false
var jump_pitch = 1.0

func _ready():
	Game.GUN == true
	#anim.play("run")
	#hide_all_sprites()
	#wheel.visible = true
	#body.visible = true
	#Input.action_press("jump")
#	
	#Input.action_release("jump")


func _physics_process(delta):

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

	if velocity.y > 1500:
		taking_damage()
		velocity.y = 0

	shoot_lazor()

func hide_all_sprites():
	wheel.visible = false
	body.visible = false
	jump.visible = false
	fall.visible = false


func taking_damage():
	if active:
		velocity.y = 0
		gravity = 600
		$Die.play()
		active = false
		get_node("CollisionShape2D").set_deferred("disabled", true)
		emit_signal("robot_died")
		#await get_tree().create_timer(0.5).timeout
		$AllSprites.hide()
		var effect_instance : CPUParticles2D = robot_death_effect.instantiate()
		effect_instance.position = position
		effect_instance.emitting = true
		get_parent().add_child(effect_instance)
		#await get_tree().create_timer(0.5).timeout
		#get_tree().paused = true
	else:
		pass


func shoot_lazor():
	#if LAZOR:
	if Game.GUN:
		if Input.is_action_pressed("shoot") and shooting_cooldown_timer.is_stopped() and not is_on_wall():
			var direction = -1
			var f = PLASMABALL.instantiate()
			f.direction = direction * -1
			get_parent().add_child(f)
			f.position.y = position.y - 5
			f.position.x = position.x - 30 * direction
			fire_logic()


func fire_logic():
	$GunFire.play()
	shooting_cooldown_timer.start()


func app_pickup(app):
	match app:
		0: #JUMP
			$NotesMessages/Areas.visible = true
			top_note.text = "JUMP APP"
			bottom_note.text = "YOU CAN JUMP!"
			app_anim.play("jump_note")
			$AppNoteTimer.start()
		1: #DOUBLE JUMP
			$NotesMessages/Areas.visible = true
			top_note.text = "JUMP ADDON"
			bottom_note.text = "YOU CAN DOUBLE JUMP!"
			app_anim.play("double_jump_note")
			$AppNoteTimer.start()
		2: #GUN
			$NotesMessages/Areas.visible = true
			top_note.text = "DEFENSE APP"
			bottom_note.text = "YOU CAN FIRE DEADLY LAZORZ!"
			app_anim.play("gun_note")
			$AppNoteTimer.start()


func _on_app_note_timer_timeout():
	$NotesMessages/Areas.visible = false
