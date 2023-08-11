extends CharacterBody2D

var MAX_SPEED = 300
var direction = 1

@onready var wallCheck = $WallCheck
@export var enemy_death_effect : PackedScene
@export var health :int

func _ready():
	get_node("AnimatedSprite2D").play("Fly")

func _physics_process(delta):
	var found_wall = is_on_wall()
	if found_wall:
		direction *= -1
		$Timer3.start(0.0005)
		$Timer4.start(1)
	velocity.x += direction * MAX_SPEED * (delta * 1.5)
	if direction > 0:
		get_node("AnimatedSprite2D").flip_h = false
		$WallCheck.position = (Vector2(17,0))
	else:
		get_node("AnimatedSprite2D").flip_h = true
		$WallCheck.position = (Vector2(-15,0))
	move_and_slide()

func _on_timer_3_timeout():
	MAX_SPEED = 0
	velocity.x = 0
	get_node("AnimatedSprite2D").play("Idle")

func _on_timer_4_timeout():
	MAX_SPEED = 300
	get_node("AnimatedSprite2D").play("Fly")

func _on_area_2d_body_entered(body):
	#if body.name == "NewRobot":
	if body.is_in_group("Robots"):
		body.taking_damage()
		#Game.lose_life()
	#elif body.get_collision_layer_value(16): Not fucking working!!
	elif body.is_in_group("Lazor") or body.is_in_group("Plasmaball"):
		if health > 0:
			health -= 1
			$ProjectileHit.play()
			
			# NEW SHADER METHOD BELOW
			var TW4 = get_tree().create_tween()
			TW4.tween_property($AnimatedSprite2D.material, 
			"shader_parameter/flashState", 1.0, 0.05)
			TW4.tween_property($AnimatedSprite2D.material, 
			"shader_parameter/flashState", 0.0, 0.05)
			# NEW SHADER METHOD ABOVE

			# OLD WHITE-OUT CODE BELOW
			#var TW1 = get_tree().create_tween()
			#TW1.set_loops(1)
			#TW1.tween_property($AnimatedSprite2D, "modulate",
			#Color(1000,1000,1000),0.05)
			#TW1.tween_property($AnimatedSprite2D, "modulate",Color.WHITE,0)
			# OLD WHITE-OUT CODE ABOVE

			body.queue_free()
		else:
			get_node("AnimatedSprite2D").play("Idle")
			set_physics_process(false)
			$AnimatedSprite2D.play("Idle")
			$Area2D/CollisionShape2D.queue_free()
			$Screetch.play()
			
			# NEW SHADER METHOD BELOW
			var TW5 = get_tree().create_tween()
			TW5.tween_property($AnimatedSprite2D.material, "shader_parameter/flashState", 
			1.0, 1.0) #.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
			# NEW SHADER METHOD ABOVE

			# OLD WHITE-OUT CODE BELOW
			# DEATH WHITE-OUT
			#var TW2 = get_tree().create_tween()
			#TW2.set_loops(1)
			#TW2.tween_property($AnimatedSprite2D, "modulate",
			#Color(10000,10000,10000),15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
			# OLD WHITE-OUT CODE ABOVE

			# 	DEATH STARS
			body.queue_free()
			$Timer.start()

func _on_timer_timeout():
	get_node("AnimatedSprite2D").play("Idle")
	$Die.play()
	var effect_instance : GPUParticles2D = enemy_death_effect.instantiate()
	var TW3 = get_tree().create_tween()
	TW3.set_loops(1)
	TW3.tween_property(effect_instance, "modulate",Color.HOT_PINK,1)
	effect_instance.position = position
	effect_instance.emitting = true
	get_parent().add_child(effect_instance)
	$AnimatedSprite2D.hide()
	$Timer2.start()

func _on_timer_2_timeout():
	get_node("AnimatedSprite2D").play("Idle")
	queue_free()
	
	# OLD KILL/DIE CODE
	
	#elif body.name == "Plasmaball":
	#	var effect_instance : GPUParticles2D = enemy_death_effect.instantiate()
	#	var TW1 = get_tree().create_tween()
	#	TW1.set_loops(1)
	#	TW1.tween_property(effect_instance, "modulate",Color.HOT_PINK,1)
	#	effect_instance.position = position
	#	effect_instance.emitting = true
	#	get_parent().add_child(effect_instance)
	#	body.queue_free()
	#	queue_free()
