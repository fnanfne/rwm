extends CharacterBody2D

var SPEED = 60
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
@export var health :int

@onready var edgeCheck = $EdgeCheck
@export var enemy_death_effect : PackedScene

func _ready():
	get_node("AnimationPlayer").play("Idle")

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
	if body.name == "NewRobot":
		body.taking_damage()
		#Game.lose_life()
	#elif body.get_collision_layer_value(16): Not fucking working!!
	elif body.name == "Plasmaball":
		if health > 0:
			health -= 1
			var TW2 = get_tree().create_tween()
			TW2.set_loops(1)
			TW2.tween_property($Complete_Sprite, "modulate",
			Color(25500,25500,25500),0.05)
			TW2.tween_property($Complete_Sprite, "modulate",Color.WHITE,0)
			body.queue_free()
			$ProjectileHit.play()
		else:
			var effect_instance : GPUParticles2D = enemy_death_effect.instantiate()
			var TW1 = get_tree().create_tween()
			TW1.set_loops(1)
			TW1.tween_property(effect_instance, "modulate",Color.RED,1)
			effect_instance.position = position
			effect_instance.emitting = true
			get_parent().add_child(effect_instance)
			body.queue_free()
			queue_free()
			$ProjectileHit.play()
