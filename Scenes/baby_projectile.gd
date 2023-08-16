extends CharacterBody2D

const SPEED = 200
const GRAVITY = 25
const BOUNCE = -300
const BABY = preload("res://Redguy/Redguy.tscn")

var direction = 1
var bounce_amount = 0

func _ready():
	velocity.x = SPEED * direction

func _physics_process(_delta):
	#print(velocity.x)
	$Sprite2D.rotation_degrees += 25 * direction
	velocity.y += GRAVITY
	if is_on_wall():
		spawn_a_baby()
		queue_free()

	if is_on_floor():
		velocity.y = BOUNCE
		$PlasmaBounce.play()
		if bounce_amount == 2:
			spawn_a_baby()
			queue_free()
			$PlasmaExplode.play()
		else:
			bounce_amount += 1

	move_and_slide()

func _on_screen_exited():
	queue_free()

func explode():
	$Timer.start()

func _on_timer_timeout():
	queue_free()

func spawn_a_baby():
	var f = BABY.instantiate()
	f.direction = direction * -1
	get_parent().call_deferred("add_child",f)
	f.position.y = position.y - 5
	f.position.x = position.x - 5 * direction
