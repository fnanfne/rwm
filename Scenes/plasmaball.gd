extends CharacterBody2D

var direction = 1
const SPEED = 300
const GRAVITY = 25
const BOUNCE = -300

func _ready():
	velocity.x = SPEED * direction

func _physics_process(_delta):
	#print(velocity.x)
	$Sprite2D.rotation_degrees += 25 * direction
	velocity.y += GRAVITY
	if is_on_wall():
		set_physics_process(false)
		$Sprite2D.hide()
		$PlasmaExplode.play()
		explode()

	if is_on_floor():
		velocity.y = BOUNCE
		#$PlasmaBounce.play()

	move_and_slide()

func _on_screen_exited():
	queue_free()

func explode():
	$Timer.start()

func _on_timer_timeout():
	queue_free()
