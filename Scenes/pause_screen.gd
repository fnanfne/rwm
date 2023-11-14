extends CanvasLayer

@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var resume_button : Button = find_child("ResumeButton")
@onready var restart_button : Button = find_child("ConfirmRestartButton")
@onready var menu_button : Button = find_child("MenuButton")
@onready var options_button : Button = find_child("QOptionsButton")

@onready var sound_volume_label: Label = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Audio/Sound/SoundVolume
@onready var music_volume_label: Label = $ColorRect/CenterContainer/PanelContainer/MarginContainer/Audio/Music/MusicVolume

# SECTION 1
@onready var jump_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Jump
@onready var jump_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator4
@onready var double_jump_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Double_Jump
@onready var double_jump_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator5
@onready var gun_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Gun
@onready var gun_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator6
@onready var zoom_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Zoom
@onready var zoom_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator7
@onready var launch_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Launch
@onready var launch_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator8
# SECTION 2
@onready var annihilate_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Annihilate
@onready var annihilate_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator9
@onready var helmet_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Helmet
@onready var helmet_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator10
@onready var heart_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Heart
@onready var heart_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator11
@onready var gun_upgrade_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Gun_Upgrade
@onready var gun_upgrade_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator12
@onready var explozors_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Explozors
@onready var explozors_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator13
# SECTION 3
@onready var haxxor_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Haxxor
@onready var haxxor_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator14
@onready var timesaver_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/TimeSaver
@onready var timesaver_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator15
@onready var velcro_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Velcro
@onready var velcro_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator16
@onready var crystal_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Crystal
@onready var crystal_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator17
@onready var bitcoin_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Bitcoin
@onready var bitcoin_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator18
# SECTION 4
@onready var delete_jump_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Delete_Jump
@onready var delete_jump_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator19
@onready var delete_gun_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Delete_Gun
@onready var delete_gun_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator20
@onready var delete_launch_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Delete_Launch
@onready var delete_launch_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator21
@onready var delete_zoom_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Delete_Zoom
@onready var delete_zoom_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator22
@onready var delete_helmet_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Delete_Helmet
@onready var delete_helmet_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator23
# SECTION 5
@onready var rgb_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/RGB_Keys
@onready var rgb_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator24
@onready var goldkey_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/GoldKey
@onready var goldkey_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator25
@onready var push_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/Push
@onready var push_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator26
@onready var walljump_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/WallJump
@onready var walljump_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator27
@onready var firewalk_section = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/FireWalk
@onready var firewalk_separator = $ColorRect/PanelContainer2/MarginContainer/VBoxContainer/HSeparator28
# SECTION 6

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
#	pass # Replace with function body.
	_begin_level_variables()


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


func _on_help_button_pressed():
	$ColorRect/PanelContainer2.visible = true
	$ColorRect/CenterContainer.visible = false


func _on_backfrom_help_pressed():
	$ColorRect/PanelContainer2.visible = false
	$ColorRect/CenterContainer.visible = true


func _begin_level_variables():
	Game.healthContainers = 0
	Game.BTC = 0
	Game.YELLOWKEYS = 0
	Game.CRYSTALS = 0
	Game.JUMP = false
	Game.DOUBLEJUMP = false
	Game.HAXXOR = false
	Game.HEMLET = false
	Game.GUN = false
	Game.LAUNCH = false
	Game.ZOOM = false
	Game.ANNIHILATE = false
	Game.EXPLOZORZ = false
	Game.VELCRO = false
	Game.REDKEY = false
	Game.GREENKEY = false
	Game.BLUEKEY = false
	Game.PUSHBLOCK = false


func _on_section_1_pressed():
	_section_1_visible()
	_section_2_hide()
	_section_3_hide()
	_section_4_hide()
	_section_5_hide()


func _on_section_2_pressed():
	_section_2_visible()
	_section_1_hide()
	_section_3_hide()
	_section_4_hide()
	_section_5_hide()


func _on_section_3_pressed():
	_section_3_visible()
	_section_1_hide()
	_section_2_hide()
	_section_4_hide()
	_section_5_hide()


func _on_section_4_pressed():
	_section_4_visible()
	_section_1_hide()
	_section_2_hide()
	_section_3_hide()
	_section_5_hide()


func _on_section_5_pressed():
	_section_5_visible()
	_section_1_hide()
	_section_2_hide()
	_section_3_hide()
	_section_4_hide()


func _section_1_visible():
	jump_section.visible = true
	jump_separator.visible = true
	double_jump_section.visible = true
	double_jump_separator.visible = true
	gun_section.visible = true
	gun_separator.visible = true
	zoom_section.visible = true
	zoom_separator.visible = true
	launch_section.visible = true
	launch_separator.visible = true

func _section_1_hide():
	jump_section.visible = false
	jump_separator.visible = false
	double_jump_section.visible = false
	double_jump_separator.visible = false
	gun_section.visible = false
	gun_separator.visible = false
	zoom_section.visible = false
	zoom_separator.visible = false
	launch_section.visible = false
	launch_separator.visible = false

func _section_2_visible():
	annihilate_section.visible = true
	annihilate_separator.visible = true
	helmet_section.visible = true
	helmet_separator.visible = true
	heart_section.visible = true
	heart_separator.visible = true
	gun_upgrade_section.visible = true
	gun_upgrade_separator.visible = true
	explozors_section.visible = true
	explozors_separator.visible = true

func _section_2_hide():
	annihilate_section.visible = false
	annihilate_separator.visible = false
	helmet_section.visible = false
	helmet_separator.visible = false
	heart_section.visible = false
	heart_separator.visible = false
	gun_upgrade_section.visible = false
	gun_upgrade_separator.visible = false
	explozors_section.visible = false
	explozors_separator.visible = false

func _section_3_visible():
	haxxor_section.visible = true
	haxxor_separator.visible = true
	timesaver_section.visible = true
	timesaver_separator.visible = true
	velcro_section.visible = true
	velcro_separator.visible = true
	crystal_section.visible = true
	crystal_separator.visible = true
	bitcoin_section.visible = true
	bitcoin_separator.visible = true

func _section_3_hide():
	haxxor_section.visible = false
	haxxor_separator.visible = false
	timesaver_section.visible = false
	timesaver_separator.visible = false
	velcro_section.visible = false
	velcro_separator.visible = false
	crystal_section.visible = false
	crystal_separator.visible = false
	bitcoin_section.visible = false
	bitcoin_separator.visible = false

func _section_4_visible():
	delete_jump_section.visible = true
	delete_jump_separator.visible = true
	delete_gun_section.visible = true
	delete_gun_separator.visible = true
	delete_launch_section.visible = true
	delete_launch_separator.visible = true
	delete_zoom_section.visible = true
	delete_zoom_separator.visible = true
	delete_helmet_section.visible = true
	delete_helmet_separator.visible = true

func _section_4_hide():
	delete_jump_section.visible = false
	delete_jump_separator.visible = false
	delete_gun_section.visible = false
	delete_gun_separator.visible = false
	delete_launch_section.visible = false
	delete_launch_separator.visible = false
	delete_zoom_section.visible = false
	delete_zoom_separator.visible = false
	delete_helmet_section.visible = false
	delete_helmet_separator.visible = false

func _section_5_visible():
	rgb_section.visible = true
	rgb_separator.visible = true
	goldkey_section.visible = true
	goldkey_separator.visible = true
	push_section.visible = true
	push_separator.visible = true
	walljump_section.visible = true
	walljump_separator.visible = true
	firewalk_section.visible = true
	firewalk_separator.visible = true

func _section_5_hide():
	rgb_section.visible = false
	rgb_separator.visible = false
	goldkey_section.visible = false
	goldkey_separator.visible = false
	push_section.visible = false
	push_separator.visible = false
	walljump_section.visible = false
	walljump_separator.visible = false
	firewalk_section.visible = false
	firewalk_separator.visible = false

func _section_6_visible():
	pass

func _section_6_hide():
	pass

