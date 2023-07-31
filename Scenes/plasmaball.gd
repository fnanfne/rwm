extends CharacterBody2D

var direction = 1
const SPEED = 500
const GRAVITY = 25
const BOUNCE = -300

func _ready():
	velocity.x = SPEED * direction

func _physics_process(_delta):
	$Sprite2D.rotation_degrees += 25 * direction
	velocity.y += GRAVITY
	if is_on_wall() or velocity.x == 0:
		queue_free()

	if is_on_floor():
		velocity.y = BOUNCE

	move_and_slide()

func _on_screen_exited():
	queue_free()


func _on_timer_timeout():
	$PlasmaSound.play()
