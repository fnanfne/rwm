extends CharacterBody2D

var SPEED = 60
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

@onready var edgeCheck = $EdgeCheck
@export var enemy_death_effect : PackedScene
@export var health :int

#var edgecheckposition = get_node("EdgeCheck").position.x

func _ready():
	get_node("AnimationPlayer").play("Walking")

func _physics_process(delta):
	#print(get_node("EdgeCheck").position.x)
	var found_wall = is_on_wall()
	var found_edge = not edgeCheck.is_colliding()
	if found_wall or found_edge:
		direction *= -1
	velocity.y += gravity * delta
	velocity.x = direction * SPEED
	if direction > 0:
		#get_node("BodySprite").flip_h = false # This doesn't work anymore due to the new skeletal animation
		get_node("BodySprite").set_scale(Vector2(-1,1))
		#get_node("EdgeCheck").position(Vector2(13,20))
		$EdgeCheck.position = (Vector2(13,20))
	else:
		#get_node("BodySprite").flip_h = true # This doesn't work anymore due to the new skeletal animation
		get_node("BodySprite").set_scale(Vector2(1,1))
		#get_node("EdgeCheck").position(Vector2(-22,20))
		$EdgeCheck.position = (Vector2(-22,20))
	move_and_slide()

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
			direction *= -1

			# NEW SHADER METHOD BELOW
			var TW4 = get_tree().create_tween()
			TW4.tween_property($BodySprite.material, 
			"shader_parameter/flashState", 1.0, 0.05)
			TW4.tween_property($BodySprite.material, 
			"shader_parameter/flashState", 0.0, 0.05)
			# NEW SHADER METHOD ABOVE

			# OLD WHITE-OUT CODE BELOW
			#var TW1 = get_tree().create_tween()
			#TW1.set_loops(1)
			#TW1.tween_property($BodySprite, "modulate",
			#Color(1000,1000,1000),0.05)
			#TW1.tween_property($BodySprite, "modulate",Color.WHITE,0)
			# OLD WHITE-OUT CODE ABOVE

			body.queue_free()
		else:
			set_physics_process(false)
			$AnimationPlayer.pause()
			$Area2D/CollisionShape2D.queue_free()
			$Screetch.play()
			
			# NEW SHADER METHOD BELOW
			var TW5 = get_tree().create_tween()
			TW5.tween_property($BodySprite.material, "shader_parameter/flashState", 
			1.0, 1.0) #.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
			# NEW SHADER METHOD ABOVE

			# OLD WHITE-OUT CODE BELOW
			# DEATH WHITE-OUT
			#var TW2 = get_tree().create_tween()
			#TW2.set_loops(1)
			#TW2.tween_property($BodySprite, "modulate",
			#Color(10000,10000,10000),15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
			# OLD WHITE-OUT CODE ABOVE
	
			# 	DEATH STARS
			body.queue_free()
			$Timer.start()

func _on_timer_timeout():
	$Die.play()
	var effect_instance : GPUParticles2D = enemy_death_effect.instantiate()
	var TW3 = get_tree().create_tween()
	TW3.set_loops(1)
	TW3.tween_property(effect_instance, "modulate",Color.RED,1)
	effect_instance.position = position
	effect_instance.emitting = true
	get_parent().add_child(effect_instance)
	$BodySprite.hide()
	$Timer2.start()

func _on_timer_2_timeout():
	queue_free()
	
	# OLD KILL/DIE CODE

	#elif body.name == "Plasmaball":
	#	var effect_instance : GPUParticles2D = enemy_death_effect.instantiate()
	#	var TW1 = get_tree().create_tween()
	#	TW1.set_loops(1)
	#	TW1.tween_property(effect_instance, "modulate",Color.RED,1)
	#	effect_instance.position = position
	#	effect_instance.emitting = true
	#	get_parent().add_child(effect_instance)
	#	body.queue_free()
	#	queue_free()
