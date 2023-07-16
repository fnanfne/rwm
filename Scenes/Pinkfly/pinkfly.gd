extends CharacterBody2D

var SPEED = 200
var direction = 1

@onready var wallCheck = $WallCheck

func _ready():
	get_node("AnimatedSprite2D").play("Fly")

func _physics_process(_delta):
	var found_wall = is_on_wall()
	if found_wall:
		direction *= -1
		$Timer.start(0.0005)
		$Timer2.start(1)
	velocity.x = direction * SPEED
	if direction > 0:
		get_node("AnimatedSprite2D").flip_h = false
		$WallCheck.position = (Vector2(17,0))
	else:
		get_node("AnimatedSprite2D").flip_h = true
		$WallCheck.position = (Vector2(-15,0))
	move_and_slide()

func _on_timer_timeout():
	SPEED = 0
	get_node("AnimatedSprite2D").play("Idle")

func _on_timer_2_timeout():
	SPEED = 200
	get_node("AnimatedSprite2D").play("Fly")
