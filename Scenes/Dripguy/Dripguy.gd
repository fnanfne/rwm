extends CharacterBody2D

@export var enemy_death_effect : PackedScene

func _physics_process(_delta):
	pass

func _on_area_2d_body_entered(body):
	if body.name == "NewRobot":
		body.taking_damage()
		#Game.lose_life()
	#elif body.get_collision_layer_value(16): Not fucking working!!
	elif body.name == "Plasmaball":
		var effect_instance : GPUParticles2D = enemy_death_effect.instantiate()
		var TW1 = get_tree().create_tween()
		TW1.set_loops(1)
		TW1.tween_property(effect_instance, "modulate",Color.ORANGE_RED,1)
		effect_instance.position = position
		effect_instance.emitting = true
		get_parent().add_child(effect_instance)
		body.queue_free()
		queue_free()
