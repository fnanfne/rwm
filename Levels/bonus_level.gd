extends Node2D

@export var world_speed = 300

@onready var moving_environment = $"/root/BonusLevel/Environment/Static"
@onready var start_in = %StartIn
@onready var start_in_label = %StartInLabel
@onready var animation_player = $AnimationPlayer

var platform_1 = preload("res://Scenes/platform_1.tscn")
var platform_2 = preload("res://Scenes/platform_2.tscn")
var rng = RandomNumberGenerator.new()
var rng_platform = RandomNumberGenerator.new()
var last_platform_position = Vector2.ZERO
var next_spawn_time = 0


func _ready():
	rng.randomize()
	get_tree().paused = true
	animation_player.play("countdown")
	await animation_player.animation_finished
	get_tree().paused = false
	$Timer.start()


func _process(_delta):
	#print($Timer.time_left)
	# Spawn a new platform
	if Time.get_ticks_msec() > next_spawn_time:
		_spawn_next_platform()


func _spawn_next_platform():
	
	var platform_number = rng_platform.randi_range(1, 2)
	var new_platform_1 = platform_1.instantiate()
	var new_platform_2 = platform_2.instantiate()
	
	if platform_number == 1:
		# Set the position of the new platform
		if last_platform_position == Vector2.ZERO:
			new_platform_1.position = Vector2(300, 0)
		else:
			var x = last_platform_position.x + rng.randi_range(250, 350)
			var y = clamp(last_platform_position.y + rng.randi_range(-150, 150), 200, 300)
			new_platform_1.position = Vector2(x, y)
		
		# Add the platform to the moving environment
		moving_environment.add_child(new_platform_1)
		
		# Update the last platform position and increase the next spawn time
		last_platform_position = new_platform_1.position
		next_spawn_time += world_speed
	else:
			# Set the position of the new platform
		if last_platform_position == Vector2.ZERO:
			new_platform_2.position = Vector2(300, 0)
		else:
			var x = last_platform_position.x + rng.randi_range(250, 350)
			var y = clamp(last_platform_position.y + rng.randi_range(-150, 150), 200, 300)
			new_platform_2.position = Vector2(x, y)
		
		# Add the platform to the moving environment
		moving_environment.add_child(new_platform_2)
		
		# Update the last platform position and increase the next spawn time
		last_platform_position = new_platform_2.position
		next_spawn_time += world_speed
	
	# Set the position of the new platform
	
	#if last_platform_position == Vector2.ZERO:
	#	new_platform_1.position = Vector2(400, 0)
	#else:
	#	var x = last_platform_position.x + rng.randi_range(450, 550)
	#	var y = clamp(last_platform_position.y + rng.randi_range(-150, 150), 200, 1000)
	#	new_platform_1.position = Vector2(x, y)
	#
	## Add the platform to the moving environment
	#moving_environment.add_child(new_platform_1)
	#
	# Update the last platform position and increase the next spawn time
	#last_platform_position = new_platform_1.position
	#next_spawn_time += world_speed


func _physics_process(delta):
	# Move the plaforms left
	moving_environment.position.x -= world_speed * delta


func _on_timer_timeout():
	$Camera2D/ColorRect2.visible = true
