extends CharacterBody2D

var SPEED = 60
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

@onready var edgeCheck = $EdgeCheck

#var edgecheckposition = get_node("EdgeCheck").position.x

func _ready():
	get_node("AnimationPlayer").play("Walking")

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
