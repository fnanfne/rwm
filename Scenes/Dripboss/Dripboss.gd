extends CharacterBody2D

var SPEED = 60
var vertical_direction = 1
var horizontal_direction = 1
const ACID = preload("res://Scenes/slime_projectile.tscn")

@onready var ceilingfloorCheck = $CeilingFloorCheck
@onready var wallsCheck = $WallsCheck
@onready var topCornersCheck = $TopCornersCheck
@onready var bottomCornersCheck = $BottomCornersCheck
@export var enemy_death_effect : PackedScene
@export var health :int

func _physics_process(_delta):
	# VARIABLES
	var found_ceiling = is_on_ceiling()
	var found_floor = is_on_floor()
	var found_wall = is_on_wall()
	# MOVEMENT
	if velocity.x == 0 and velocity.y == 0:
		vertical_direction *= -1 #randf_range(-1, 1)
		horizontal_direction *= -1 #randf_range(-1, 1)
	# CHECKING FOR FLOOR/CEILING
	if found_ceiling or found_floor:
		vertical_direction *= -1
	# FLIPPING FLOOR/CELING CHECK
	if vertical_direction > 0:
		$CeilingFloorCheck.position = (Vector2(0,40))
	else:
		$CeilingFloorCheck.position = (Vector2(0,-40))
	# CHECKING FOR WALLS
	if found_wall:
		horizontal_direction *= -1
	# FLIPPING WALLS CHECK
	if horizontal_direction > 0:
		$WallsCheck.position = (Vector2(40,0))
	else:
		$WallsCheck.position = (Vector2(-40,0))

	velocity.y = vertical_direction * SPEED
	velocity.x = horizontal_direction * SPEED

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
			TW1.tween_property($Body, "modulate",
			Color(1000,1000,1000),0.05)
			TW1.tween_property($Body, "modulate",Color.WHITE,0)
			body.queue_free()
		else:
			get_node("Body").play("Idle")
			set_physics_process(false)
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
	get_node("Body").play("Idle")
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
	get_node("Body").play("Idle")
	queue_free()

func _on_animated_sprite_2d_2_frame_change(frame: int):
	#print('frame: ', frame)
	if frame == 15:
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
	if frame == 9:
		var f = ACID.instantiate()
		get_parent().add_child(f)
		f.position.y = position.y + 10
		f.position.x = position.x + 50
		$SlimeDrip.play()
		var TW2 = f.create_tween()
		TW2.set_loops(0)
		TW2.tween_property(f, "rotation", 
		0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		TW2.tween_property(f, "rotation", 
		-0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		var f2 = ACID.instantiate()
		get_parent().add_child(f2)
		f2.position.y = position.y - 40
		f2.position.x = position.x - 50
		$SlimeDrip.play()
		var TW3 = f2.create_tween()
		TW3.set_loops(0)
		TW3.tween_property(f, "rotation", 
		0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		TW2.tween_property(f, "rotation", 
		-0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if frame == 13:
		var f = ACID.instantiate()
		get_parent().add_child(f)
		f.position.y = position.y - 40
		f.position.x = position.x + 50
		$SlimeDrip.play()
		var TW1 = f.create_tween()
		TW1.set_loops(0)
		TW1.tween_property(f, "rotation", 
		0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		TW1.tween_property(f, "rotation", 
		-0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if frame == 4:
		var f = ACID.instantiate()
		get_parent().add_child(f)
		f.position.y = position.y + 40
		f.position.x = position.x - 40
		$SlimeDrip.play()
		var TW1 = f.create_tween()
		TW1.set_loops(0)
		TW1.tween_property(f, "rotation", 
		0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		TW1.tween_property(f, "rotation", 
		-0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		var f2 = ACID.instantiate()
		get_parent().add_child(f2)
		f2.position.y = position.y - 40
		f2.position.x = position.x + 50
		$SlimeDrip.play()
		var TW2 = f2.create_tween()
		TW2.set_loops(0)
		TW2.tween_property(f2, "rotation", 
		0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		TW2.tween_property(f2, "rotation", 
		-0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		var f3 = ACID.instantiate()
		get_parent().add_child(f3)
		f3.position.y = position.y - 40
		f3.position.x = position.x -20
		$SlimeDrip.play()
		var TW3 = f3.create_tween()
		TW3.set_loops(0)
		TW3.tween_property(f3, "rotation", 
		0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		TW3.tween_property(f3, "rotation", 
		-0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		var f4 = ACID.instantiate()
		get_parent().add_child(f4)
		f4.position.y = position.y + 20
		f4.position.x = position.x + 15
		$SlimeDrip.play()
		var TW4 = f4.create_tween()
		TW4.set_loops(0)
		TW4.tween_property(f4, "rotation", 
		0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		TW4.tween_property(f4, "rotation", 
		-0.18, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
