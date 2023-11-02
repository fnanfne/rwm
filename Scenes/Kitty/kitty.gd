extends CharacterBody2D

#@onready var win_screen : CanvasLayer = find_child("WinScreen")
#@onready var win_screen = $WinScreen
@onready var level_timer = $LevelTimer/LevelTimer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var level_time = 0.0
var start_level_msec = 0.0

func _ready():
	# LEVEL TIMER
	start_level_msec = Time.get_ticks_msec()

func _physics_process(delta):
	
	# LEVEL TIMER
	level_time = Time.get_ticks_msec() - start_level_msec - 2000
	#print(level_time/1000.0)
	#print(corrected_level_time/1000.0)
	#print($LevelTimer/LevelTimer/HBoxContainer/Seconds.text)

	# GRAVITY.
	if not is_on_floor():
		velocity.y += gravity * delta

	# ALWAYS LOOKING AT ROBOT	
	if Game.Robot.global_position.x > global_position.x:
		$Body.flip_h = false
		$Body/Tail.flip_h = false
		$Body/Blink.flip_h = false
	else:
		$Body.flip_h = true
		$Body/Tail.flip_h = true
		$Body/Blink.flip_h = true

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Robots"):
		#get_tree().paused = true
		level_timer.stop_timer()
		body.set_physics_process(false)
		$AnimationPlayer.stop()
		#get_tree().set_physics_process(false) #not working
		$Meow.play()
		await $Meow.finished
		$GotKitty.play()
		await $GotKitty.finished
		#get_tree().paused = false
		#win_screen.visible = true
		#$MenuSong.play()
		#get_tree().AudioStreamPlayer.stop()
		#get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")
