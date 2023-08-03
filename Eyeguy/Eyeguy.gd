extends CharacterBody2D

var SPEED = 50
var direction = 1

@onready var ceilingfloorCheck = $CeilingFloorCheck
@export var enemy_death_effect : PackedScene
@export var health :int

func _ready():
	get_node("PupilAnimationPlayer").play("Idle")
	get_node("Eyeguy_Body").play("Idle")
	get_node("BlinkAnimationPlayer").play("Idle")

func _physics_process(_delta):
	var found_ceiling = is_on_ceiling()
	var found_floor = is_on_floor()
	if found_ceiling or found_floor:
		direction *= -1
	velocity.y = direction * SPEED
	if direction > 0:
		$CeilingFloorCheck.position = (Vector2(0,20))
	else:
		$CeilingFloorCheck.position = (Vector2(0,-16))
	
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
			var TW1 = get_tree().create_tween()
			TW1.set_loops(1)
			TW1.tween_property($".", "modulate",
			Color(1000,1000,1000),0.05)
			TW1.tween_property($".", "modulate",Color.WHITE,0)
			body.queue_free()
		else:
			get_node("Eyeguy_Body").play("Idle")
			set_physics_process(false)
			$Area2D/CollisionShape2D.queue_free()
			$Screetch.play()
			# DEATH WHITE-OUT
			var TW2 = get_tree().create_tween()
			TW2.set_loops(1)
			TW2.tween_property($".", "modulate",
			Color(10000,10000,10000),15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
			# 	DEATH STARS
			body.queue_free()
			$Timer.start()

func _on_timer_timeout():
	get_node("Eyeguy_Body").play("Idle")
	$Die.play()
	var effect_instance : GPUParticles2D = enemy_death_effect.instantiate()
	var TW3 = get_tree().create_tween()
	TW3.set_loops(1)
	TW3.tween_property(effect_instance, "modulate",Color.BLUE,1)
	effect_instance.position = position
	effect_instance.emitting = true
	get_parent().add_child(effect_instance)
	$".".hide()
	$Timer2.start()

func _on_timer_2_timeout():
	get_node("Eyeguy_Body").play("Idle")
	queue_free()
	
	# OLD KILL/DIE CODE
	
	#elif body.name == "Plasmaball":
	#	var effect_instance : GPUParticles2D = enemy_death_effect.instantiate()
	#	var TW1 = get_tree().create_tween()
	#	TW1.set_loops(1)
	#	TW1.tween_property(effect_instance, "modulate",Color.BLUE,1)
	#	effect_instance.position = position
	#	effect_instance.emitting = true
	#	get_parent().add_child(effect_instance)
	#	body.queue_free()
	#	queue_free()
