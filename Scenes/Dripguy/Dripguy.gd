extends CharacterBody2D

@export var enemy_death_effect : PackedScene
@export var health :int
const ACID = preload("res://Scenes/slime_projectile.tscn")

func _ready():
	play_randomized("Idle")
	
func _physics_process(_delta):
	pass

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
			$AnimatedSprite2D.pause()
			$AnimationPlayer.pause()
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
	TW3.tween_property(effect_instance, "modulate",Color.ORANGE_RED,1)
	effect_instance.position = position
	effect_instance.emitting = true
	get_parent().add_child(effect_instance)
	$AnimatedSprite2D.hide()
	$Timer2.start()

func _on_timer_2_timeout():
	get_node("AnimatedSprite2D").play("Idle")
	queue_free()

func _on_animation_change(frame: int):
	#print('frame: ', frame)
	if $AnimatedSprite2D.visible:
		if frame == 0:
			var f = ACID.instantiate()
			get_parent().add_child(f)
			f.position.y = position.y + 10
			f.position.x = position.x
			$SlimeDrip.play()
			var TW1 = f.create_tween()
			TW1.set_loops(0)
			TW1.tween_property(f, "rotation", 
			0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			TW1.tween_property(f, "rotation", 
			-0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func play_randomized(Idle : String):
	randomize()
	$AnimationPlayer.play(Idle)
	var offset : float = randf_range(0, $AnimationPlayer.current_animation_length)
	$AnimationPlayer.advance(offset)
