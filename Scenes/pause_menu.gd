extends Control

@export var game_manager : GameManager

func _ready():
	hide()
	game_manager.connect("toggle_game_paused", _on_game_manager_toggle_game_paused)

func _process(_delta):
	pass

func _on_game_manager_toggle_game_paused(is_paused: bool):
	if(is_paused):
		show()
	else:
		hide()


func _on_resume_button_pressed():
	game_manager.game_paused = false
	#pass


func _on_exit_button_pressed():
	get_tree().quit()
	#pass # Replace with function body.
