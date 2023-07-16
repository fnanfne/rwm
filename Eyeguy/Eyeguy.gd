extends CharacterBody2D

var SPEED = 50
var direction = 1

@onready var ceilingfloorCheck = $CeilingFloorCheck

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
