extends CharacterBody2D

var SPEED = 70
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
const GLOW = preload("res://Scenes/glow_projectile.tscn")

@export var health :int
@onready var edgeCheck = $EdgeCheck
@export var enemy_death_effect : PackedScene

func _ready():
	get_node("AnimationPlayer").play("Idle")
	var TW2 = get_tree().create_tween()
	TW2.set_loops(0)
	TW2.tween_property($Complete_Sprite, "scale",
	Vector2(1.02,0.98),0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	TW2.tween_property($Complete_Sprite, "scale",
	Vector2(0.98,1.02),0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _physics_process(delta):
	#print(health)
	var found_wall = is_on_wall()
	var found_edge = not edgeCheck.is_colliding()
	if found_wall or found_edge:
		direction *= -1
	velocity.y += gravity * delta
	velocity.x = direction * SPEED
	if direction > 0:
		get_node("Complete_Sprite/Eyeboss_Body/AnimatedSprite2D").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_00").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_01").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_02").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_03").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_04").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_05").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_06").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_07").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_08").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_09").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_10").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_00").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_01").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_02").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_03").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_04").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_05").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_06").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_07").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_08").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_09").flip_h = false
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_10").flip_h = false
		get_node("Complete_Sprite").set_scale(Vector2(-1,1))
		#get_node("EdgeCheck").position(Vector2(13,20))
		$EdgeCheck.position = (Vector2(68,16))
	else:
		get_node("Complete_Sprite/Eyeboss_Body/AnimatedSprite2D").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_00").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_01").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_02").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_03").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_04").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_05").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_06").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_07").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_08").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_09").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyes/Eye_10").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_00").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_01").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_02").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_03").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_04").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_05").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_06").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_07").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_08").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_09").flip_h = true
		get_node("Complete_Sprite/Eyeboss_eyelids/Eyelid_10").flip_h = true
		get_node("Complete_Sprite").set_scale(Vector2(1,1))
		#get_node("EdgeCheck").position(Vector2(-22,20))
		$EdgeCheck.position = (Vector2(-68,16))
	move_and_slide()

func _on_area_2d_body_entered(body):
	#if body.name == "NewRobot":
	if body.is_in_group("Robots"):
		body.taking_damage()
		#Game.lose_life()
	elif body.is_in_group("Lazor") or body.is_in_group("Plasmaball"):
		if health > 0:
			health -= 1
			$ProjectileHit.play()
			var TW1 = get_tree().create_tween()
			TW1.set_loops(1)
			TW1.tween_property($Complete_Sprite, "modulate",
			Color(1000,1000,1000),0.05)
			TW1.tween_property($Complete_Sprite, "modulate",Color.WHITE,0)
			body.queue_free()
		else:
			set_physics_process(false)
			$Area2D/CollisionShape2D.queue_free()
			$Screetch.play()
			# DEATH WHITE-OUT
			var TW2 = get_tree().create_tween()
			TW2.set_loops(1)
			TW2.tween_property($Complete_Sprite, "modulate",
			Color(10000,10000,10000),15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
			# 	DEATH STARS
			body.queue_free()
			$Timer.start()

func _on_timer_timeout():
	$Die.play()
	var effect_instance : GPUParticles2D = enemy_death_effect.instantiate()
	var TW3 = get_tree().create_tween()
	TW3.set_loops(1)
	TW3.tween_property(effect_instance, "modulate",Color.BLUE,1)
	effect_instance.position = position
	effect_instance.emitting = true
	get_parent().add_child(effect_instance)
	$Complete_Sprite.hide()
	$Timer2.start()

func _on_timer_2_timeout():
	queue_free()

func _on_animated_sprite_2d_frame_change(frame: int):
	#print('frame: ', frame)
	if frame == 15 or frame == 5 or frame == 10 or frame == 20:
		# PROJECTILE #1 - RIGHT
		var f1 = GLOW.instantiate()
		get_parent().add_child(f1)
		f1.position.y = position.y - 50
		f1.position.x = position.x + 40
		# PROJECTILE #2 - LEFT
		var f2 = GLOW.instantiate()
		get_parent().add_child(f2)
		f2.position.y = position.y - 50
		f2.position.x = position.x - 40
		f2.velocity.x = 220 * -1
