extends Control

@onready var player_username = $HBoxContainer/VBoxContainer/UsernameBox/LineEdit
@onready var player_email = $HBoxContainer/VBoxContainer/EmailBox/LineEdit
@onready var player_password = $HBoxContainer/VBoxContainer/PasswordBox/LineEdit
@onready var player_password_confirm = $HBoxContainer/VBoxContainer/PasswordConfirmBox/LineEdit
@onready var notification = $Notification


# Called when the node enters the scene tree for the first time.
func _ready():
	SilentWolf.Auth.sw_registration_complete.connect(_on_registration_complete)


func _on_registration_complete(sw_result: Dictionary) -> void:
	if sw_result.success:
		notification.text = "Registration succeeded!"
		print("Registration succeeded!")
	else:
		notification.text = "Error: " + str(sw_result.error)
		print("Error: " + str(sw_result.error))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_line_edit_text_submitted(player_text):
	Game.close_menu = true
	print(player_text)
	Game.player_name = player_text


func _on_submit_button_pressed():
	SilentWolf.Auth.register_player(player_username.text, player_email.text, player_password.text, player_password_confirm.text)
