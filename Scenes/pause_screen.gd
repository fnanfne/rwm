extends CanvasLayer

@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var resume_button : Button = find_child("ResumeButton")
@onready var restart_button : Button = find_child("ConfirmRestartButton")
@onready var menu_button : Button = find_child("MenuButton")
@onready var options_button : Button = find_child("QOptionsButton")

@onready var sound_volume_label: Label = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Audio/Sound/SoundVolume
@onready var music_volume_label: Label = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Audio/Music/MusicVolume

@export var sound_sample: AudioStream
@export var music_sample: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/CenterContainer.hide()
	anim.play("Unpause")
	resume_button.pressed.connect(unpause)
	restart_button.pressed.connect(get_tree().reload_current_scene)
	restart_button.pressed.connect(unpause)
	#menu_button.pressed.connect(get_tree().quit)
	#quit_button.pressed.connect(get_tree().quit)
	SoundManager.set_sound_volume(0.5)
	sound_volume_label.text = "50%"
	SoundManager.set_music_volume(0.5)
	music_volume_label.text = "50%"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func unpause():
	$ColorRect/CenterContainer.hide()
	anim.play("Unpause")
	get_tree().paused = false
	
	# FREES THE MOUSE, SO IT CAN BE USED IN THE PAUSE MENU ??
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func pause():
	$ColorRect/CenterContainer.show()
	anim.play("Pause")
	get_tree().paused = true
	
	# FREES THE MOUSE, SO IT CAN BE USED IN THE PAUSE MENU ??
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

#unc _unhandled_input(event: InputEvent) -> void:
func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		if get_tree().paused:
			unpause()
		else:
			pause()


func _on_menu_button_pressed():
	#get_tree().tree_exiting
	#Game.xPos = Game.Robot.position.x
	#Game.yPos = Game.Robot.position.y
	#Game.save_data()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_quit_button_pressed():
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainer.hide()
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainer2.show()


func _on_cancel_button_pressed():
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/LevelRestart.hide()
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/Menu.show()


func _on_restart_button_pressed():
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/Menu.hide()
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/LevelRestart.show()


func _on_confirm_restart_button_pressed():
	pass # Replace with function body.


func _on_options_button_pressed():
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/Menu.hide()
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/Options.show()


func _on_audio_button_pressed():
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/Options.hide()
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/Audio.show()


func _on_video_button_pressed():
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/Options.hide()
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/Video.show()


func _on_back_from_audio_pressed():
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/Audio.hide()
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/Options.show()


func _on_back_from_options_pressed():
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/Options.hide()
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/Menu.show()


func _on_back_from_video_pressed():
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/Video.hide()
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/Options.show()


func _on_volume_down_pressed():
	var next_volume: float = clamp(SoundManager.get_sound_volume() - 0.1, 0, 1)
	SoundManager.set_sound_volume(next_volume)
	sound_volume_label.text = "%d%%" % [round(next_volume * 100)]
	SoundManager.play_sound(sound_sample)


func _on_volume_up_pressed():
	var next_volume: float = clamp(SoundManager.get_sound_volume() + 0.1, 0, 1)
	SoundManager.set_sound_volume(next_volume)
	sound_volume_label.text = "%d%%" % [round(next_volume * 100)]
	SoundManager.play_sound(sound_sample)


func _on_music_volume_down_pressed():
	var next_volume: float = clamp(SoundManager.get_music_volume() - 0.1, 0, 1)
	SoundManager.set_music_volume(next_volume)
	music_volume_label.text = "%d%%" % [round(next_volume * 100)]
	SoundManager.play_sound(music_sample)


func _on_music_volume_up_pressed():
	var next_volume: float = clamp(SoundManager.get_music_volume() + 0.1, 0, 1)
	SoundManager.set_music_volume(next_volume)
	music_volume_label.text = "%d%%" % [round(next_volume * 100)]
	SoundManager.play_sound(music_sample)


func _on_full_screen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_borderless_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_vsync_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
