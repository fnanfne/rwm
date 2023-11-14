extends Control

@onready var menu = $VBoxContainer
@onready var options = $Options
@onready var video = $Video
@onready var audio = $Audio
@onready var music = $Music
@onready var abcdeffghijkl = $ABCDEFFGHIJKL
@onready var mnopqrstuvwxyz = $MNOPQRSTUVWXYZ
@onready var levels = $Levels
@onready var sound_volume_label: Label = $Audio/Sound/SoundVolume
@onready var music_volume_label: Label = $Audio/Music/MusicVolume
@onready var greeting = $Greeting

@export var sound_sample: AudioStream
@export var music_sample: AudioStream

# PLAYER REGISTER SCENE BELOW
@onready var register = $Register

const SWLogger = preload("res://addons/silent_wolf/utils/SWLogger.gd")

const EXCEPTIONS = [" ", "!",'"',"£","$","%","^","&","*","(",")",
"`","¬","[","]","{","}","-","+","=",";",":","'","@","#","~",",","<",".",
">","/","?","_","|"]

var username : LineEdit
var submit_button : Button
@onready var username_length_check = $Register/VBoxContainer/HBoxContainer2/VBoxContainer2/UsernameBox/PlayerName.text
# PLAYER REGISTER SCENE ABOVE

# PLAYER LOGIN SCENE BELOW
@onready var login = $Login
# PLAYER LOGIN SCENE ABOVE

# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.set_sound_volume(0.5)
	sound_volume_label.text = "50%"
	SoundManager.set_music_volume(0.5)
	music_volume_label.text = "50%"

####### PLAYER REGISTER SCENE BELOW #######
	SilentWolf.check_auth_ready()
	SilentWolf.Auth.sw_registration_complete.connect(_on_registration_complete)
	SilentWolf.Auth.sw_registration_user_pwd_complete.connect(_on_registration_user_pwd_complete)
	username = $"Register/VBoxContainer/HBoxContainer2/VBoxContainer2/UsernameBox/PlayerName"
	submit_button = $"Register/HBoxContainer/SubmitButton"
	submit_button.disabled = true
####### PLAYER REGISTER SCENE ABOVE #######

####### PLAYER LOGIN SCENE BELOW #######
	SilentWolf.Auth.sw_login_complete.connect(_on_login_complete)
####### PLAYER LOGIN SCENE ABOVE #######

####### PLAYER REGISTER SCENE BELOW #######
func _on_player_name_text_changed(new_text):
	for exception in EXCEPTIONS:
		if new_text.find(exception) != -1 or len($Register/VBoxContainer/HBoxContainer2/VBoxContainer2/UsernameBox/PlayerName.text) <= 2:
			submit_button.disabled = true
			return
			
	if len($Register/VBoxContainer/HBoxContainer2/VBoxContainer2/UsernameBox/PlayerName.text) >= 2:
		# Enable the BUTTON_A
		submit_button.disabled = true
	else:
		#Disable the BUTTON_A
		submit_button.disabled = true
	submit_button.disabled = false


func _on_RegisterUPButton_pressed() -> void:
	var player_name = $"FormContainer/MainFormContainer/FormInputFields/PlayerName".text
	var password = $"FormContainer/MainFormContainer/FormInputFields/Password".text
	var confirm_password = $"FormContainer/MainFormContainer/FormInputFields/ConfirmPassword".text
	SilentWolf.Auth.register_player_user_password(player_name, password, confirm_password)
	show_processing_label()
	$AudioStreamPlayer.play()


func _on_registration_complete(sw_result: Dictionary) -> void:
	if sw_result.success:
		registration_success()
	else:
		registration_failure(sw_result.error)


func _on_registration_user_pwd_complete(sw_result: Dictionary) -> void:
	if sw_result.success:
		registration_user_pwd_success()
	else:
		registration_failure(sw_result.error)


func registration_success() -> void:
	# redirect to configured scene (user is logged in after registration)
	var scene_name = SilentWolf.auth_config.redirect_to_scene
	# if doing email verification, open scene to confirm email address
	if ("email_confirmation_scene" in SilentWolf.auth_config) and (SilentWolf.auth_config.email_confirmation_scene) != "":
		SWLogger.info("registration succeeded, waiting for email verification...")
		scene_name = SilentWolf.auth_config.email_confirmation_scene
	else:
		SWLogger.info("registration succeeded, logged in player: " + str(SilentWolf.Auth.logged_in_player))
	get_tree().change_scene_to_file(scene_name)


func registration_user_pwd_success() -> void:
	var scene_name = SilentWolf.auth_config.redirect_to_scene
	get_tree().change_scene_to_file(scene_name)


func registration_failure(error: String) -> void:
	hide_processing_label()
	#$"FormContainer/ErrorMessage".text = error
	#$"FormContainer/ErrorMessage".show()
	$"Register/ErrorMessage".text = error
	$"Register/ErrorMessage".show()


func _on_back_button_pressed():
	#get_tree().change_scene_to_file(SilentWolf.auth_config.redirect_to_scene)
	#get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	show_and_hide(menu, register)
	$LeaderboardsButton.visible = true
	$Sprite2D.visible = true
	$AudioStreamPlayer.play()


func show_processing_label() -> void:
	$"Register/ProcessingLabel".show()
	$"Register/ColorRect2".show()
	$"Login/FormContainer/ProcessingLabel".show()


func hide_processing_label() -> void:
	$"Register/ProcessingLabel".hide()
	$"Register/ColorRect2".hide()
	$"Login/FormContainer/ProcessingLabel".hide()


func _on_username_info_button_mouse_entered() -> void:
	$"Register/InfoBox".text = "Username should contain at least 3 characters (letters or numbers) and no spaces."
	$"Register/InfoBox".show()


func _on_username_info_button_mouse_exited() -> void:
	$"Register/InfoBox".hide()


func _on_password_info_button_mouse_entered() -> void:
	$"Register/InfoBox".text = "Password should contain at least 8 characters including uppercase and lowercase letters, numbers and (optionally) special characters."
	$"Register/InfoBox".show()


func _on_password_info_button_mouse_exited() -> void:
	$"Register/InfoBox".hide()


func _on_submit_button_pressed() -> void:
	var player_name = $"Register/VBoxContainer/HBoxContainer2/VBoxContainer2/UsernameBox/PlayerName".text
	var email = $"Register/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailBox/Email".text
	var password = $"Register/VBoxContainer/HBoxContainer2/VBoxContainer2/PasswordBox/Password".text
	var confirm_password = $"Register/VBoxContainer/HBoxContainer2/VBoxContainer2/PasswordConfirmBox/ConfirmPassword".text
	SilentWolf.Auth.register_player(player_name, email, password, confirm_password)
	show_processing_label()
	$AudioStreamPlayer.play()
####### PLAYER REGISTER SCENE ABOVE #######

####### PLAYER LOGIN SCENE BELOW #######
func _on_LoginButton_pressed() -> void:
	var username = $"FormContainer/UsernameContainer/Username".text
	var password = $"FormContainer/PasswordContainer/Password".text
	var remember_me = $"FormContainer/RememberMeCheckBox".is_pressed()
	SWLogger.debug("Login form submitted, remember_me: " + str(remember_me))
	SilentWolf.Auth.login_player(username, password, remember_me)
	show_processing_label()
	$AudioStreamPlayer.play()


func _on_login_complete(sw_result: Dictionary) -> void:
	if sw_result.success:
		login_success()
	else:
		login_failure(sw_result.error)


func login_success() -> void:
	var scene_name = SilentWolf.auth_config.redirect_to_scene
	SWLogger.info("logged in as: " + str(SilentWolf.Auth.logged_in_player))
	get_tree().change_scene_to_file(scene_name)
	$AudioStreamPlayer2.play()


func login_failure(error: String) -> void:
	hide_processing_label()
	SWLogger.info("log in failed: " + str(error))
	$"Login/FormContainer/ErrorMessage".text = error
	$"Login/FormContainer/ErrorMessage".show()

#### ADDED THE BELOW TO THE FIRST FUNCTION CALLED show_processing_label...
#func show_processing_label() -> void:
#	$"FormContainer/ProcessingLabel".show()
#	$"FormContainer/ProcessingLabel".show()

#### ADDED THE BELOW TO THE FIRST FUNCTION CALLED hide_processing_label...
#func hide_processing_label() -> void:
#	$"FormContainer/ProcessingLabel".hide()


func _on_LinkButton_pressed() -> void:
	get_tree().change_scene_to_file(SilentWolf.auth_config.reset_password_scene)
	$AudioStreamPlayer.play()


func _on_login_back_button_pressed():
	#print("Back button pressed")
	#get_tree().change_scene_to_file(SilentWolf.auth_config.redirect_to_scene)
	#get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	show_and_hide(menu, login)
	$LeaderboardsButton.visible = true
	$Sprite2D.visible = true
	$AudioStreamPlayer.play()
####### PLAYER LOGIN SCENE ABOVE #######

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if SilentWolf.Auth.logged_in_player == null:
		pass
	else:
		greeting.text = "Hello " + str(SilentWolf.Auth.logged_in_player) + "!"
		$VBoxContainer/Menu2/Login.hide()
		$VBoxContainer/Menu2/Register.disabled = true
		$VBoxContainer/Menu2/Logout.show()
	#print($Audio/HBoxContainer/Slider/Sound.value)
	#print(SilentWolf.Auth.logged_in_player)
	if Input.is_action_just_pressed("menu_new"):
		#toggle()
		pass


func toggle():
	visible = !visible
	get_tree().paused = visible


func _on_start_pressed():
	#toggle()
	#get_tree().change_scene_to_file("res://Levels/maze_runner_-_godot.tscn")
	show_and_hide(levels, menu)
	$LeaderboardsButton.visible = false
	$Sprite2D.visible = false
	$AudioStreamPlayer.play()


func _on_options_pressed():
	show_and_hide(options, menu) # Show options, and hide menu...
	$LeaderboardsButton.visible = false
	$AudioStreamPlayer.play()


func show_and_hide(first, second): # ...With this function
	first.show()
	second.hide()


func _on_exit_pressed():
	get_tree().quit()
	$AudioStreamPlayer.play()


func _on_video_pressed():
	show_and_hide(video, options)
	$LeaderboardsButton.visible = false
	$AudioStreamPlayer.play()


func _on_audio_pressed():
	show_and_hide(audio, options)
	$AudioStreamPlayer.play()


func _on_back_from_options_pressed():
	show_and_hide(menu, options)
	$LeaderboardsButton.visible = true
	$Sprite2D.visible = true
	$AudioStreamPlayer.play()


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


func _on_back_from_video_pressed():
	show_and_hide(options, video)
	$AudioStreamPlayer.play()


func _on_sound_value_changed(value):
	volume(0, value)

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)

func _on_music_value_changed(value):
	volume(1, value)


func _on_back_from_audio_pressed():
	show_and_hide(options, audio)
	$AudioStreamPlayer.play()


func _on_music_pressed():
	show_and_hide(music, menu)
	$LeaderboardsButton.visible = false
	$AudioStreamPlayer.play()
	$Sprite2D.visible = false
	$Sprite2D2.visible = true


func _on_back_from_music_pressed():
	show_and_hide(menu, music)
	$LeaderboardsButton.visible = true
	$Sprite2D.visible = true
	$AudioStreamPlayer.play()
	$Sprite2D.visible = true
	$Sprite2D2.visible = false


func _on_abcdeffghijkl_pressed():
	show_and_hide(abcdeffghijkl, music)
	$AudioStreamPlayer.play()


func _on_mnopqrstuvwxyz_pressed():
	show_and_hide(mnopqrstuvwxyz, music)
	$AudioStreamPlayer.play()


func _on_back_from_abcdef_pressed():
	show_and_hide(music, abcdeffghijkl)
	$AudioStreamPlayer.play()


func _on_back_from_mnopqr_pressed():
	show_and_hide(music, mnopqrstuvwxyz)
	$AudioStreamPlayer.play()


func _on_back_from_levels_pressed():
	show_and_hide(menu, levels)
	$LeaderboardsButton.visible = true
	$Sprite2D.visible = true
	$AudioStreamPlayer.play()


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


func _on_login_pressed():
	#get_tree().change_scene_to_file("res://Scenes/login.tscn")
	show_and_hide(login, menu)
	$LeaderboardsButton.visible = false
	$AudioStreamPlayer.play()

func _on_register_pressed():
	show_and_hide(register, menu)
	$LeaderboardsButton.visible = false
	$AudioStreamPlayer.play()
	#get_tree().change_scene_to_file("res://Scenes/player_register.tscn")
	#res://Scenes/player_register.tscn
	#pass


func _on_login_button_pressed():
	var username = $"Login/FormContainer/UsernameContainer/Username".text
	var password = $"Login/FormContainer/PasswordContainer/Password".text
	var remember_me = $"Login/FormContainer/RememberMeCheckBox".is_pressed()
	SWLogger.debug("Login form submitted, remember_me: " + str(remember_me))
	SilentWolf.Auth.login_player(username, password, remember_me)
	show_processing_label()
	$AudioStreamPlayer.play()


func _on_logout_pressed():
	SilentWolf.Auth.logout_player()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	$AudioStreamPlayer.play()


func _on_leaderboards_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Leaderboards/Leaderboard_main.tscn")
	$AudioStreamPlayer.play()


func _on_mazerunner__godot_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/maze_runner_-_godot.tscn")
	$AudioStreamPlayer.play()


func _on_robot_wants_music_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/robot_wants_music.tscn")
	$AudioStreamPlayer.play()


func _on_gravity_blocks_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/gravity_blocks.tscn")
	$AudioStreamPlayer.play()


func _on_the_pushblock_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/the_pushblock.tscn")
	$AudioStreamPlayer.play()


func _on_moving_platforms_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/moving_platforms.tscn")
	$AudioStreamPlayer.play()


func _on_tutorial_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/tutorial.tscn")
	$AudioStreamPlayer.play()


func _on_disarmed_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/disarmed.tscn")
	$AudioStreamPlayer.play()


func _on_bonus_level_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/bonus_level.tscn")
	$AudioStreamPlayer.play()


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

