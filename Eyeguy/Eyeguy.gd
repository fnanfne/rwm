extends CharacterBody2D

var SPEED = 50
var direction = 1

@onready var ceilingfloorCheck = $CeilingFloorCheck
@export var enemy_death_effect : PackedScene

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
	if body.name == "NewRobot":
		body.taking_damage()
		#Game.lose_life()
	#elif body.get_collision_layer_value(16): Not fucking working!!
	elif body.name == "Plasmaball":
		var effect_instance : GPUParticles2D = enemy_death_effect.instantiate()
		var TW1 = get_tree().create_tween()
		TW1.set_loops(1)
		TW1.tween_property(effect_instance, "modulate",Color.BLUE,1)
		effect_instance.position = position
		effect_instance.emitting = true
		get_parent().add_child(effect_instance)
		body.queue_free()
		queue_free()
