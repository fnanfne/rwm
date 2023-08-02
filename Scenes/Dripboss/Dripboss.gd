extends CharacterBody2D

@export var enemy_death_effect : PackedScene
@export var health :int

func _physics_process(_delta):
	pass

func _on_area_2d_body_entered(body):
	if body.name == "NewRobot":
		body.taking_damage()
		#Game.lose_life()
	elif body.is_in_group("Lazor") or body.is_in_group("Plasmaball"):
		if health > 0:
			health -= 1
			$ProjectileHit.play()
			var TW1 = get_tree().create_tween()
			TW1.set_loops(1)
			TW1.tween_property($Body, "modulate",
			Color(1000,1000,1000),0.05)
			TW1.tween_property($Body, "modulate",Color.WHITE,0)
			body.queue_free()
		else:
			$Area2D/CollisionShape2D.queue_free()
			$Screetch.play()
			# DEATH WHITE-OUT
			var TW2 = get_tree().create_tween()
			TW2.set_loops(1)
			TW2.tween_property($Body, "modulate",
			Color(10000,10000,10000),15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
			# 	DEATH STARS
			body.queue_free()
			$Timer.start()

func _on_timer_timeout():
	$Die.play()
	var effect_instance : GPUParticles2D = enemy_death_effect.instantiate()
	var TW3 = get_tree().create_tween()
	TW3.set_loops(1)
	TW3.tween_property(effect_instance, "modulate",Color.ORANGE_RED,1)
	effect_instance.position = position
	effect_instance.emitting = true
	get_parent().add_child(effect_instance)
	$Body.hide()
	$Timer2.start()

func _on_timer_2_timeout():
	queue_free()
