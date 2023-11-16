extends Control

@onready var menu = $VBoxContainer
@onready var options = $Options
@onready var video = $Video
@onready var audio = $Audio
@onready var music = $Music
@onready var abcdeffghijkl = $ABCDEFFGHIJKL
@onready var mnopqrstuvwxyz = $MNOPQRSTUVWXYZ
@onready var fnanfne = $ABCDEFFGHIJKL/fnanfne
@onready var levels = $Levels
@onready var sound_volume_label: Label = $Audio/Sound/SoundVolume
@onready var music_volume_label: Label = $Audio/Music/MusicVolume
@onready var greeting = $Greeting

@onready var aero_beeps = $ABCDEFFGHIJKL
@onready var berrytheeveeboi_beeps = $ABCDEFFGHIJKL
@onready var bluedoggo123_beeps = $ABCDEFFGHIJKL
@onready var clonedrone_beeps = $ABCDEFFGHIJKL
@onready var dmd_beeps_1 = $ABCDEFFGHIJKL
@onready var dmd_beeps_2 = $ABCDEFFGHIJKL
@onready var choxolate_beeps = $ABCDEFFGHIJKL
@onready var clorpdoop_beeps = $ABCDEFFGHIJKL
@onready var donutmaster56_beeps = $ABCDEFFGHIJKL
@onready var draworigami_beeps = $ABCDEFFGHIJKL
@onready var fomb_beeps = $ABCDEFFGHIJKL
@onready var fnanfne_beeps_1 = $ABCDEFFGHIJKL/fnanfne/VBoxContainer/HBoxContainer/Beeps_Left/VBoxContainer
@onready var fnanfne_beeps_2 = $ABCDEFFGHIJKL/fnanfne/VBoxContainer/HBoxContainer/Beeps_Right/VBoxContainer
@onready var gameworm_beeps_1 = $ABCDEFFGHIJKL/gameworm/VBoxContainer/HBoxContainer/Beeps_Left/VBoxContainer
@onready var gameworm_beeps_2 = $ABCDEFFGHIJKL/gameworm/VBoxContainer/HBoxContainer/Beeps_Right/VBoxContainer
@onready var gabriel_miel_beeps = $ABCDEFFGHIJKL
@onready var ian05_beeps = $ABCDEFFGHIJKL
@onready var jadeanubis_beeps = $ABCDEFFGHIJKL
@onready var linkandar_beeps = $ABCDEFFGHIJKL
@onready var joachim_s_beeps = $ABCDEFFGHIJKL
@onready var koopaluigi_beeps = $ABCDEFFGHIJKL
@onready var mastertrek_beeps = $ABCDEFFGHIJKL
@onready var mathboy_beeps = $ABCDEFFGHIJKL
@onready var paisleypickle_beeps_1 = $ABCDEFFGHIJKL
@onready var paisleypickle_beeps_2 = $ABCDEFFGHIJKL
@onready var syncmaster_beeps = $ABCDEFFGHIJKL
@onready var profile0182983_beeps = $ABCDEFFGHIJKL
@onready var redkitty7_beeps = $ABCDEFFGHIJKL
@onready var rodentracer_beeps = $ABCDEFFGHIJKL
@onready var thetom_beeps = $ABCDEFFGHIJKL
@onready var yourmoveboyo_beeps_1 = $ABCDEFFGHIJKL
@onready var yourmoveboyo_beeps_2 = $ABCDEFFGHIJKL
@onready var ysqys_beeps = $ABCDEFFGHIJKL

@export var sound_sample: AudioStream
@export var music_sample: AudioStream

#### AERO ####
#### BERRYTHEEVEEBOI ####
#### BLUEDOGGO123 ####
#### CLONEDRONE ####
#### DONUTMASTER56 ####
#### DRAWORIGAMI ####
#### FOMB ####
#### FNANFNE ####
var fnanfne1 = preload("res://Assets/Audio/Music/fnanfne/Battletoads-Level-1.ogg")
var fnanfne2 = preload("res://Assets/Audio/Music/fnanfne/Bobby+Carrot_out.ogg")
var fnanfne3 = preload("res://Assets/Audio/Music/fnanfne/Castlevania-II-Praying-Hands_out.ogg")
var fnanfne4 = preload("res://Assets/Audio/Music/fnanfne/Coffin Dance.ogg")
var fnanfne5 = preload("res://Assets/Audio/Music/fnanfne/Commando.ogg")
var fnanfne6 = preload("res://Assets/Audio/Music/fnanfne/DuckTales-The-Moon.ogg")
var fnanfne7 = preload("res://Assets/Audio/Music/fnanfne/DuckTales-Title-Song.ogg")
var fnanfne8 = preload("res://Assets/Audio/Music/fnanfne/Hallowed+Be+Thy+Name_out.ogg")
var fnanfne9 = preload("res://Assets/Audio/Music/fnanfne/Hawkeye-Title-Screen_out.ogg")
var fnanfne10 = preload("res://Assets/Audio/Music/fnanfne/Hysteria+by+Muse_out.ogg")
var fnanfne11 = preload("res://Assets/Audio/Music/fnanfne/INFERNO - 3DSOM Keygen music.ogg")
var fnanfne12 = preload("res://Assets/Audio/Music/fnanfne/Keygen Music - CORE PowerISO.ogg")
var fnanfne13 = preload("res://Assets/Audio/Music/fnanfne/MegaMan2-DrWilysCastle.ogg")
var fnanfne14 = preload("res://Assets/Audio/Music/fnanfne/Monty on the Run.ogg")
var fnanfne15 = preload("res://Assets/Audio/Music/fnanfne/RESSURECTiON-Registry-Clean-Expert-keygen-music.ogg")
var fnanfne16 = preload("res://Assets/Audio/Music/fnanfne/SonicKnucklesBoss.ogg")
var fnanfne17 = preload("res://Assets/Audio/Music/fnanfne/Spooky Scary Skeletons.ogg")
var fnanfne18 = preload("res://Assets/Audio/Music/fnanfne/Winamp Sony Vega Unreal Super Hero 3 keygen.ogg")
var fnanfne19 = preload("res://Assets/Audio/Music/fnanfne/Zero+Wing+-+New+Day+for+Me_out.ogg")
var fnanfne20 = preload("res://Assets/Audio/Music/fnanfne/Zombie Army.ogg")
#### GAMEWORM ####
var gameworm1 = preload("res://Assets/Audio/Music/gameworm/Awakening_out.ogg")
var gameworm2 = preload("res://Assets/Audio/Music/gameworm/Beneath+the+waves_out.ogg")
var gameworm3 = preload("res://Assets/Audio/Music/gameworm/Biolabs_out.ogg")
var gameworm4 = preload("res://Assets/Audio/Music/gameworm/Cave+masters_NEW_out.ogg")
var gameworm5 = preload("res://Assets/Audio/Music/gameworm/Dance party.ogg")
var gameworm6 = preload("res://Assets/Audio/Music/gameworm/evil_out.ogg")
var gameworm7 = preload("res://Assets/Audio/Music/gameworm/Great+outdoors_NEW_out.ogg")
var gameworm8 = preload("res://Assets/Audio/Music/gameworm/Inferno_out.ogg")
var gameworm9 = preload("res://Assets/Audio/Music/gameworm/Into+chaos_NEW_out.ogg")
var gameworm10 = preload("res://Assets/Audio/Music/gameworm/Kaizo_out.ogg")
var gameworm11 = preload("res://Assets/Audio/Music/gameworm/King+of+the+abyss_out.ogg")
var gameworm12 = preload("res://Assets/Audio/Music/gameworm/Legendary boss.ogg")
var gameworm13 = preload("res://Assets/Audio/Music/gameworm/No pills allowed.ogg")
var gameworm14 = preload("res://Assets/Audio/Music/gameworm/Revival_NEW_out.ogg")
var gameworm15 = preload("res://Assets/Audio/Music/gameworm/Scrap_out.ogg")
var gameworm16 = preload("res://Assets/Audio/Music/gameworm/Spelunking_NEW_out.ogg")
var gameworm17 = preload("res://Assets/Audio/Music/gameworm/Technomare.ogg")
var gameworm18 = preload("res://Assets/Audio/Music/gameworm/Temple+guardian_out.ogg")
var gameworm19 = preload("res://Assets/Audio/Music/gameworm/trolled.ogg")
var gameworm20 = preload("res://Assets/Audio/Music/gameworm/Watcher_out.ogg")

#### GABRIEL_MIEL ####
#### IAN05 ####
#### JADEANUBIS ####
#### LINKANDAR ####
#### JOACHIM_S ####
#### KOOPALUIGI ####
#### MASTERTREK ####
#### MATHBOY ####
#### PAISLEYPICKLE ####
#### SYNCMASTER ####
#### PROFILE0182983 ####
#### REDKITTY7 ####
#### RODENTRACER ####
#### THETOM ####
#### YOURMOVEBOYO ####
#### YSQYS ####


# PLAYER REGISTER SCENE BELOW
@onready var register = $Register

const SWLogger = preload("res://addons/silent_wolf/utils/SWLogger.gd")

const EXCEPTIONS = [" ", "!",'"',"£","$","%","^","&","*","(",")",
"`","¬","[","]","{","}","-","+","=",";",":","'","@","#","~",",","<",".",
">","/","?","_","|"]

# Changed to username2 as there were some console errors, line 296
var username2 : LineEdit
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

	if Music.fnanfne == true:
		for beeps1 in fnanfne_beeps_1.get_children():
			beeps1.disabled = false
		for beeps2 in fnanfne_beeps_2.get_children():
			beeps2.disabled = false
	else:
		for beeps1 in fnanfne_beeps_1.get_children():
			beeps1.disabled = true
		for beeps2 in fnanfne_beeps_2.get_children():
			beeps2.disabled = true

	if Music.gameworm == true:
		for beeps1 in gameworm_beeps_1.get_children():
			beeps1.disabled = false
		for beeps2 in gameworm_beeps_2.get_children():
			beeps2.disabled = false
	else:
		for beeps1 in gameworm_beeps_1.get_children():
			beeps1.disabled = true
		for beeps2 in gameworm_beeps_2.get_children():
			beeps2.disabled = true

####### PLAYER REGISTER SCENE BELOW #######
	SilentWolf.check_auth_ready()
	SilentWolf.Auth.sw_registration_complete.connect(_on_registration_complete)
	SilentWolf.Auth.sw_registration_user_pwd_complete.connect(_on_registration_user_pwd_complete)
	# Changed to username2 as there were some console errors, line 296
	username2 = $"Register/VBoxContainer/HBoxContainer2/VBoxContainer2/UsernameBox/PlayerName"
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
	$ClickSound.play()


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
	$ClickSound.play()


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
	$ClickSound.play()
####### PLAYER REGISTER SCENE ABOVE #######

####### PLAYER LOGIN SCENE BELOW #######
func _on_LoginButton_pressed() -> void:
	var username = $"FormContainer/UsernameContainer/Username".text
	var password = $"FormContainer/PasswordContainer/Password".text
	var remember_me = $"FormContainer/RememberMeCheckBox".is_pressed()
	SWLogger.debug("Login form submitted, remember_me: " + str(remember_me))
	SilentWolf.Auth.login_player(username, password, remember_me)
	show_processing_label()
	$ClickSound.play()


func _on_login_complete(sw_result: Dictionary) -> void:
	if sw_result.success:
		login_success()
	else:
		login_failure(sw_result.error)


func login_success() -> void:
	var scene_name = SilentWolf.auth_config.redirect_to_scene
	SWLogger.info("logged in as: " + str(SilentWolf.Auth.logged_in_player))
	get_tree().change_scene_to_file(scene_name)
	$LoginSound.play()


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
	$ClickSound.play()


func _on_login_back_button_pressed():
	#print("Back button pressed")
	#get_tree().change_scene_to_file(SilentWolf.auth_config.redirect_to_scene)
	#get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	show_and_hide(menu, login)
	$LeaderboardsButton.visible = true
	$Sprite2D.visible = true
	$ClickSound.play()
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
	$ClickSound.play()


func _on_options_pressed():
	show_and_hide(options, menu) # Show options, and hide menu...
	$LeaderboardsButton.visible = false
	$ClickSound.play()


func show_and_hide(first, second): # ...With this function
	first.show()
	second.hide()


func _on_exit_pressed():
	get_tree().quit()
	$ClickSound.play()


func _on_video_pressed():
	show_and_hide(video, options)
	$LeaderboardsButton.visible = false
	$ClickSound.play()


func _on_audio_pressed():
	show_and_hide(audio, options)
	$ClickSound.play()


func _on_back_from_options_pressed():
	show_and_hide(menu, options)
	$LeaderboardsButton.visible = true
	$Sprite2D.visible = true
	$ClickSound.play()


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
	$ClickSound.play()


func _on_sound_value_changed(value):
	volume(0, value)

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)

func _on_music_value_changed(value):
	volume(1, value)


func _on_back_from_audio_pressed():
	show_and_hide(options, audio)
	$ClickSound.play()


func _on_music_pressed():
	show_and_hide(music, menu)
	$LeaderboardsButton.visible = false
	$ClickSound.play()
	$Sprite2D.visible = false
	$Sprite2D2.visible = true


func _on_back_from_music_pressed():
	show_and_hide(menu, music)
	$LeaderboardsButton.visible = true
	$Sprite2D.visible = true
	$ClickSound.play()
	$Sprite2D.visible = true
	$Sprite2D2.visible = false


func _on_abcdeffghijkl_pressed():
	show_and_hide(abcdeffghijkl, music)
	$ClickSound.play()


func _on_mnopqrstuvwxyz_pressed():
	show_and_hide(mnopqrstuvwxyz, music)
	$ClickSound.play()


func _on_back_from_abcdef_pressed():
	show_and_hide(music, abcdeffghijkl)
	$ClickSound.play()


func _on_back_from_mnopqr_pressed():
	show_and_hide(music, mnopqrstuvwxyz)
	$ClickSound.play()


func _on_back_from_levels_pressed():
	show_and_hide(menu, levels)
	$LeaderboardsButton.visible = true
	$Sprite2D.visible = true
	$ClickSound.play()


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
	$ClickSound.play()

func _on_register_pressed():
	show_and_hide(register, menu)
	$LeaderboardsButton.visible = false
	$ClickSound.play()
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
	$ClickSound.play()


func _on_logout_pressed():
	SilentWolf.Auth.logout_player()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	$ClickSound.play()


func _on_leaderboards_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Leaderboards/Leaderboard_main.tscn")
	$ClickSound.play()


func _on_mazerunner__godot_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/maze_runner_-_godot.tscn")
	$ClickSound.play()


func _on_robot_wants_music_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/robot_wants_music.tscn")
	$ClickSound.play()


func _on_gravity_blocks_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/gravity_blocks.tscn")
	$ClickSound.play()


func _on_the_pushblock_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/the_pushblock.tscn")
	$ClickSound.play()


func _on_moving_platforms_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/moving_platforms.tscn")
	$ClickSound.play()


func _on_tutorial_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/tutorial.tscn")
	$ClickSound.play()


func _on_disarmed_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/disarmed.tscn")
	$ClickSound.play()


func _on_bonus_level_pressed():
	$MenuSong.stop()
	_begin_level_variables()
	get_tree().change_scene_to_file("res://Levels/bonus_level.tscn")
	$ClickSound.play()


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

######### AERO ##########


######### BERRYTHEEVEEBOI ##########


######### BLUEDOGGO123 ##########


######### CLONEDRONE ##########


######### DMD ##########


######### CHOXOLATE ##########


######### CLORPDOOP ##########


######### DONUTMASTER56 ##########


######### DRAWORIGAMI ##########


######### FOMB ##########


######### FNANFNE ##########
func _on_fnanfne_pressed():
	$ClickSound.play()
	$MenuSong.stop()
	#show_and_hide(fnanfne, abcdeffghijkl)
	$ABCDEFFGHIJKL/fnanfne.visible = true
	$ABCDEFFGHIJKL/ABCDEF.visible = false
	$ABCDEFFGHIJKL/FGHIJKL.visible = false
	$ABCDEFFGHIJKL/BackFromABCDEF.visible = false


func _on_back_from_fnanfne_pressed():
	$ClickSound.play()
	$BeepSong.stop()
	$MenuSong.play()
	#show_and_hide(fnanfne, abcdeffghijkl)
	$ABCDEFFGHIJKL/fnanfne.visible = false
	$ABCDEFFGHIJKL/ABCDEF.visible = true
	$ABCDEFFGHIJKL/FGHIJKL.visible = true
	$ABCDEFFGHIJKL/BackFromABCDEF.visible = true


func _on_battletoads_level_1_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne1
	$BeepSong.play()


func _on_bobby_carrot_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne2
	$BeepSong.play()


func _on_castlevania_ii_praying_hands_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne3
	$BeepSong.play()


func _on_coffin_dance_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne4
	$BeepSong.play()


func _on_commando_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne5
	$BeepSong.play()


func _on_duck_tales_the_moon_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne6
	$BeepSong.play()


func _on_duck_tales_title_song_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne7
	$BeepSong.play()


func _on_hallowed_be_thy_name_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne8
	$BeepSong.play()


func _on_hawkeye_title_screen_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne9
	$BeepSong.play()


func _on_hysteria_by_muse_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne10
	$BeepSong.play()


func _on_inferno__3dsom_keygen_music_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne11
	$BeepSong.play()


func _on_core_power_iso_keygen_music_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne12
	$BeepSong.play()


func _on_mega_man_2__dr_wilys_castle_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne13
	$BeepSong.play()


func _on_monty_on_the_run_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne14
	$BeepSong.play()


func _on_ressurec_ti_on_registry_keygen_music_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne15
	$BeepSong.play()


func _on_sonic_knuckles_boss_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne16
	$BeepSong.play()


func _on_spooky_scary_skeletons_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne17
	$BeepSong.play()


func _on_unreal_super_hero_3_keygen_music_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne18
	$BeepSong.play()


func _on_zero_wing__new_day_for_me_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne19
	$BeepSong.play()


func _on_zombie_army_pressed():
	$BeepSong.stop()
	$BeepSong.stream = fnanfne20
	$BeepSong.play()


######### GAMEWORM ##########
func _on_gameworm_pressed():
	$ClickSound.play()
	$MenuSong.stop()
	#show_and_hide(fnanfne, abcdeffghijkl)
	$ABCDEFFGHIJKL/gameworm.visible = true
	$ABCDEFFGHIJKL/ABCDEF.visible = false
	$ABCDEFFGHIJKL/FGHIJKL.visible = false
	$ABCDEFFGHIJKL/BackFromABCDEF.visible = false


func _on_back_from_gameworm_pressed():
	$ClickSound.play()
	$BeepSong.stop()
	$MenuSong.play()
	#show_and_hide(fnanfne, abcdeffghijkl)
	$ABCDEFFGHIJKL/gameworm.visible = false
	$ABCDEFFGHIJKL/ABCDEF.visible = true
	$ABCDEFFGHIJKL/FGHIJKL.visible = true
	$ABCDEFFGHIJKL/BackFromABCDEF.visible = true


func _on_awakening_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm1
	$BeepSong.play()


func _on_beneath_the_waves_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm2
	$BeepSong.play()


func _on_biolabs_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm3
	$BeepSong.play()


func _on_cave_masters_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm4
	$BeepSong.play()


func _on_dance_party_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm5
	$BeepSong.play()


func _on_evil_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm6
	$BeepSong.play()


func _on_great_outdoors_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm7
	$BeepSong.play()


func _on_inferno_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm8
	$BeepSong.play()


func _on_into_chaos_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm9
	$BeepSong.play()


func _on_kaizo_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm10
	$BeepSong.play()


func _on_king_of_the_abyss_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm11
	$BeepSong.play()


func _on_legendary_boss_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm12
	$BeepSong.play()


func _on_no_pills_allowed_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm13
	$BeepSong.play()


func _on_revival_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm14
	$BeepSong.play()


func _on_scrap_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm15
	$BeepSong.play()


func _on_spelunking_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm16
	$BeepSong.play()


func _on_technomare_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm17
	$BeepSong.play()


func _on_temple_guardian_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm18
	$BeepSong.play()


func _on_trolled_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm19
	$BeepSong.play()


func _on_watcher_pressed():
	$BeepSong.stop()
	$BeepSong.stream = gameworm20
	$BeepSong.play()


######### GABRIEL_MIEL ##########


######### IAN05 ##########


######### JADEANUBIS ##########


######### LINKANDAR ##########


######### JOACHIM_S ##########


######### KOOPALUIGI ##########


######### MASTERTREK ##########


######### MATHBOY ##########


######### PAISLEYPICKLE ##########


######### SYNCMASTER ##########


######### PROFILE0182983 ##########


######### REDKITTY7 ##########


######### RODENTRACER ##########


######### THETOM ##########


######### YOURMOVEBOYO ##########


######### YSQYS ##########


