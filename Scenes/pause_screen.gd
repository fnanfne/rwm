extends CanvasLayer

@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var resume_button : Button = find_child("ResumeButton")
@onready var restart_button : Button = find_child("ConfirmRestartButton")
@onready var menu_button : Button = find_child("MenuButton")
@onready var quit_button : Button = find_child("QuitButton")

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/CenterContainer.hide()
	anim.play("Unpause")
	resume_button.pressed.connect(unpause)
	restart_button.pressed.connect(get_tree().reload_current_scene)
	restart_button.pressed.connect(unpause)
	#menu_button.pressed.connect(get_tree().quit)
	quit_button.pressed.connect(get_tree().quit)


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
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_quit_button_pressed():
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainer.hide()
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainer2.show()


func _on_cancel_button_pressed():
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainer2.hide()
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainer.show()


func _on_restart_button_pressed():
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainer.hide()
	$ColorRect/CenterContainer/PanelContainer/MarginContainer/VBoxContainer2.show()


func _on_confirm_restart_button_pressed():
	pass # Replace with function body.
