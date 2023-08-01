extends CharacterBody2D

var MAX_SPEED = 300
var direction = 1

@onready var wallCheck = $WallCheck
@export var enemy_death_effect : PackedScene

func _ready():
	get_node("AnimatedSprite2D").play("Fly")

func _physics_process(delta):
	var found_wall = is_on_wall()
	if found_wall:
		direction *= -1
		$Timer.start(0.0005)
		$Timer2.start(1)
	velocity.x += direction * MAX_SPEED * (delta * 1.5)
	if direction > 0:
		get_node("AnimatedSprite2D").flip_h = false
		$WallCheck.position = (Vector2(17,0))
	else:
		get_node("AnimatedSprite2D").flip_h = true
		$WallCheck.position = (Vector2(-15,0))
	move_and_slide()

func _on_timer_timeout():
	MAX_SPEED = 0
	velocity.x = 0
	get_node("AnimatedSprite2D").play("Idle")

func _on_timer_2_timeout():
	MAX_SPEED = 300
	get_node("AnimatedSprite2D").play("Fly")

func _on_area_2d_body_entered(body):
	if body.name == "NewRobot":
		body.taking_damage()
		#Game.lose_life()
	#elif body.get_collision_layer_value(16): Not fucking working!!
	elif body.name == "Plasmaball":
		var effect_instance : GPUParticles2D = enemy_death_effect.instantiate()
		var TW1 = get_tree().create_tween()
		TW1.set_loops(1)
		TW1.tween_property(effect_instance, "modulate",Color.HOT_PINK,1)
		effect_instance.position = position
		effect_instance.emitting = true
		get_parent().add_child(effect_instance)
		body.queue_free()
		queue_free()
