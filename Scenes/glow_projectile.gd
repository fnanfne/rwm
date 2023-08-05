extends CharacterBody2D

var direction = 1
const SPEED = 220
const GRAVITY = 10

var size_min = 0.1
var size_max = 0.5
var should_shrink = true
var rate = 0.3

func _ready():
	velocity.x = SPEED * direction
	velocity.y = 300 * direction * -1
	$Sprite2D2.scale.x = 0.4
	$Sprite2D2.scale.y = 0.4

func _physics_process(_delta):
	#print(velocity.x)
	$Sprite2D1.rotation_degrees += 12 * direction
	velocity.y += GRAVITY
	if is_on_wall():
		set_physics_process(false)
		$Sprite2D1.hide()
		#$PlasmaExplode.play()
		explode()

	if is_on_floor():
		set_physics_process(false)
		$Sprite2D1.hide()
		explode()
		
	if should_shrink:
		_shrink(rate)
		if $Sprite2D2.scale.x <= size_min:
			should_shrink = false
			
	if not should_shrink:
		_grow(rate)
		if $Sprite2D2.scale.x >= size_max:
			should_shrink = true

	move_and_slide()

func _on_screen_exited():
	queue_free()

func explode():
	$Timer.start()

func _on_timer_timeout():
	queue_free()

func _shrink(amount):
	$Sprite2D2.scale.x -= amount
	$Sprite2D2.scale.y -= amount
	
func _grow(amount):
		$Sprite2D2.scale.x += amount
		$Sprite2D2.scale.y += amount
