extends CharacterBody2D

const PROJECTILE = preload("res://Scenes/baby_projectile.tscn")

var SPEED = 60
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
var spawning_a_baby = false

@export var health :int
@export var enemy_death_effect : PackedScene

@onready var edgeCheck = $EdgeCheck
@onready var Robot = get_tree().get_first_node_in_group("Robots")

func _ready():
	get_node("AnimationPlayer").play("Idle")

func _physics_process(delta):
	#print(get_node("EdgeCheck").position.x)
	#print($Timer3.time_left)
	#print(group_members)
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
		$Area2D/Right.position = (Vector2(-25,0))
		$Area2D2/Left.position = (Vector2(25,0))
	else:
		#get_node("BodySprite").flip_h = true # This doesn't work anymore due to the new skeletal animation
		get_node("BodySprite").set_scale(Vector2(1,1))
		#get_node("EdgeCheck").position(Vector2(-22,20))
		$EdgeCheck.position = (Vector2(-22,20))
		$Area2D/Right.position = (Vector2(25,0))
		$Area2D2/Left.position = (Vector2(-25,0))
	move_and_slide()

func _on_area_2d_body_entered(body):
	#print("RIGHT SIDE")
	#if body.name == "NewRobot":
	if body.is_in_group("Robots"):
		body.taking_damage()
		#Game.lose_life()
	elif body.is_in_group("Lazor") or body.is_in_group("Plasmaball"):
		direction *= -1
		if health > 0:
			health -= 1
			$ProjectileHit.play()
			if spawning_a_baby:
				pass
			else:
				spawn_a_projectile()
				spawning_a_baby = true
				$Timer3.start()
			
			# NEW SHADER METHOD BELOW
			var TW4 = get_tree().create_tween()
			TW4.tween_property($BodySprite.material, 
			"shader_parameter/flashState", 1.0, 0.05)
			TW4.tween_property($BodySprite.material, 
			"shader_parameter/flashState", 0.0, 0.05)
			# NEW SHADER METHOD ABOVE
			
			# OLD WHITE-OUT CODE BELOW
			#var TW1 = get_tree().create_tween()
			#var TW4 = get_tree().create_tween()
			#TW1.set_loops(1)
			#TW4.set_loops(1)
			#TW1.tween_property($BodySprite, "modulate",
			#Color(1000,1000,1000),0.05)
			#TW4.tween_property($BodySprite/Jaw, "modulate",
			#Color(1000,1000,1000),0.05)
			#TW1.tween_property($BodySprite, "modulate",Color.WHITE,0)
			#TW4.tween_property($BodySprite/Jaw, "modulate",Color.WHITE,0)
			# OLD WHITE-OUT CODE ABOVE

			body.queue_free()
		else:
			get_node("BodySprite").play("Idle")
			set_physics_process(false)
			$AnimationPlayer.pause()
			$Area2D/Right.queue_free()
			$Area2D2/Left.queue_free()
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
			# OLD WHITE-OUT CODE above

			# 	DEATH STARS
			body.queue_free()
			$Timer.start()

func _on_area_2d_2_body_entered(body):
	#print("LEFT SIDE")

	#if body.name == "NewRobot":
	if body.is_in_group("Robots"):
		body.taking_damage()
		#Game.lose_life()
	elif body.is_in_group("Lazor") or body.is_in_group("Plasmaball"):
		#direction *= -1
		if health > 0:
			health -= 1
			$ProjectileHit.play()
			if spawning_a_baby:
				pass
			else:
				spawn_a_projectile()
				spawning_a_baby = true
				$Timer3.start()

			var TW4 = get_tree().create_tween()
			TW4.tween_property($BodySprite.material, 
			"shader_parameter/flashState", 1.0, 0.05)
			TW4.tween_property($BodySprite.material, 
			"shader_parameter/flashState", 0.0, 0.05)

			body.queue_free()
		else:
			get_node("BodySprite").play("Idle")
			set_physics_process(false)
			$AnimationPlayer.pause()
			$Area2D/Right.queue_free()
			$Area2D2/Left.queue_free()
			$Screetch.play()

			var TW5 = get_tree().create_tween()
			TW5.tween_property($BodySprite.material, "shader_parameter/flashState", 
			1.0, 1.0) #.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

			# 	DEATH STARS
			body.queue_free()
			$Timer.start()

func _on_timer_timeout():
	get_node("BodySprite").play("Idle")
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
	get_node("BodySprite").play("Idle")
	queue_free()
	#get_tree().call_group("Babies","queue_free")

func spawn_a_projectile():
	randomize()
	var options = [-1,1]
	var rand_value = options[randi() % options.size()]
	var f = PROJECTILE.instantiate()
	f.direction = rand_value #direction * -1
	f.add_to_group("Babies")
	#get_parent().add_child(f) # This gives an error for some reason and I have to use the below.
	get_parent().call_deferred("add_child",f)
	f.position.y = position.y - 50
	f.position.x = position.x
	var group_members = get_tree().get_nodes_in_group("Robots")
	print(group_members)

func _on_timer_3_timeout():
	spawning_a_baby = false
