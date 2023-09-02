extends Control

const SWLogger = preload("res://addons/silent_wolf/utils/SWLogger.gd")

const EXCEPTIONS = [" ", "!",'"',"£","$","%","^","&","*","(",")",
"`","¬","[","]","{","}","-","+","=",";",":","'","@","#","~",",","<",".",
">","/","?","_","|"]

var username : LineEdit
var submit_button : Button
@onready var username_length_check = $VBoxContainer/HBoxContainer2/VBoxContainer2/UsernameBox/PlayerName.text


func _physics_process(_delta):
	#print(username_length_check)
	pass

func _ready():
	SilentWolf.check_auth_ready()
	SilentWolf.Auth.sw_registration_complete.connect(_on_registration_complete)
	SilentWolf.Auth.sw_registration_user_pwd_complete.connect(_on_registration_user_pwd_complete)
	username = $"VBoxContainer/HBoxContainer2/VBoxContainer2/UsernameBox/PlayerName"
	submit_button = $"HBoxContainer/SubmitButton"
	submit_button.disabled = true

	#username.connect("text_changed", self, "_on_username_text_changed")
	#username.connect("text_changed", _on_username_text_changed)
	#username.connect("text_changed", _on_player_name_text_changed)

#func _on_username_text_changed(new_text):
#	for exception in EXCEPTIONS:
#		if new_text.find(exception) != -1:
#			submit_button.disabled = true
#			return
#			
#	submit_button.disabled = false


func _on_player_name_text_changed(new_text):
	#if len($VBoxContainer/HBoxContainer2/VBoxContainer2/UsernameBox/PlayerName.text) >= 2:
	#	# Enable the BUTTON_A
	#	submit_button.disabled = true
	#else:
#		# Disable the BUTTON_A
#		#submit_button.disabled = true
	for exception in EXCEPTIONS:
		if new_text.find(exception) != -1 or len($VBoxContainer/HBoxContainer2/VBoxContainer2/UsernameBox/PlayerName.text) <= 2:
			submit_button.disabled = true
			return
			
	if len($VBoxContainer/HBoxContainer2/VBoxContainer2/UsernameBox/PlayerName.text) >= 2:
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
	$"ErrorMessage".text = error
	$"ErrorMessage".show()


func _on_back_button_pressed():
	#get_tree().change_scene_to_file(SilentWolf.auth_config.redirect_to_scene)
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func show_processing_label() -> void:
	$"ProcessingLabel".show()
	$"ColorRect2".show()


func hide_processing_label() -> void:
	$"ProcessingLabel".hide()
	$"ColorRect2".hide()


func _on_username_info_button_mouse_entered() -> void:
	$"InfoBox".text = "Username should contain at least 3 characters (letters or numbers) and no spaces."
	$"InfoBox".show()


func _on_username_info_button_mouse_exited() -> void:
	$"InfoBox".hide()


func _on_password_info_button_mouse_entered() -> void:
	$"InfoBox".text = "Password should contain at least 8 characters including uppercase and lowercase letters, numbers and (optionally) special characters."
	$"InfoBox".show()


func _on_password_info_button_mouse_exited() -> void:
	$"InfoBox".hide()


func _on_submit_button_pressed() -> void:
	var player_name = $"VBoxContainer/HBoxContainer2/VBoxContainer2/UsernameBox/PlayerName".text
	var email = $"VBoxContainer/HBoxContainer2/VBoxContainer2/EmailBox/Email".text
	var password = $"VBoxContainer/HBoxContainer2/VBoxContainer2/PasswordBox/Password".text
	var confirm_password = $"VBoxContainer/HBoxContainer2/VBoxContainer2/PasswordConfirmBox/ConfirmPassword".text
	SilentWolf.Auth.register_player(player_name, email, password, confirm_password)
	show_processing_label()



