extends Node2D

signal game_over

@export var world_speed = 300

@onready var moving_environment = $"/root/BonusLevel/Environment/Static"
@onready var start_in = %StartIn
@onready var start_in_label = %StartInLabel
@onready var animation_player = $AnimationPlayer
@onready var bonus_robot = $"/root/BonusLevel/BonusRobot"
@onready var ground = $"/root/BonusLevel/Environment/Static/Ground"

var platform_1 = preload("res://Scenes/platform_1.tscn")
var platform_2 = preload("res://Scenes/platform_2.tscn")
var platform_enemy = preload("res://Scenes/platform_enemy.tscn")
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
	bonus_robot.robot_died.connect(_on_robot_died)
	#ground.body_entered.connect(_on_ground_body_entered)


func _process(_delta):
	if not bonus_robot.active:
		return
	#print($Timer.time_left)
	# Spawn a new platform
	if Time.get_ticks_msec() > next_spawn_time:
		_spawn_next_platform()


func _spawn_next_platform():
	
	var platform_number = rng_platform.randi_range(1, 3)
	var new_platform_1 = platform_1.instantiate()
	var new_platform_2 = platform_2.instantiate()
	var new_platform_enemy = platform_enemy.instantiate()
	
	
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

	if platform_number == 2:
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

	if platform_number == 3:
			# Set the position of the new platform
		if last_platform_position == Vector2.ZERO:
			new_platform_enemy.position = Vector2(300, 0)
		else:
			var x = last_platform_position.x + rng.randi_range(250, 350)
			var y = clamp(last_platform_position.y + rng.randi_range(-150, 150), 200, 300)
			new_platform_enemy.position = Vector2(x, y)
		
		# Add the platform to the moving environment
		moving_environment.add_child(new_platform_enemy)
		
		# Update the last platform position and increase the next spawn time
		last_platform_position = new_platform_enemy.position
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
	if not bonus_robot.active:
		return

	# Move the plaforms left
	moving_environment.position.x -= world_speed * delta


func _on_timer_timeout():
	$Camera2D/ColorRect2.visible = true


func _on_robot_died():
	emit_signal("game_over")


#func _on_ground_body_entered(body):
#	if body.is_in_group("Robots"):
#		bonus_robot.taking_damage()
