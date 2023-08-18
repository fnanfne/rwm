extends CanvasLayer

@onready var textbox_container = $TextboxContainer

var toggleWindowOpen = false

func _ready():
	hide_debug_window()
	#show_debug_window()

func _process(_delta):
	if Input.is_action_just_pressed("debug_window"):
		if toggleWindowOpen == false:
			show_debug_window()
			toggleWindowOpen = true
		else:
			hide_debug_window()
			toggleWindowOpen = false

func hide_debug_window():
	textbox_container.hide()
	
func show_debug_window():
	textbox_container.show()


func _on_jump_check_box_toggled(button_pressed):
	if button_pressed == true:
		Game.JUMP = true
	else:
		Game.JUMP = false


func _on_d_jump_check_box_toggled(button_pressed):
	pass # Replace with function body.


func _on_gun_check_box_toggled(button_pressed):
	pass # Replace with function body.


func _on_ann_check_box_toggled(button_pressed):
	pass # Replace with function body.


func _on_helmet_check_box_toggled(button_pressed):
	pass # Replace with function body.


func _on_zoom_check_box_toggled(button_pressed):
	pass # Replace with function body.


func _on_launch_check_box_toggled(button_pressed):
	pass # Replace with function body.


func _on_option_button_toggled(button_pressed):
	pass # Replace with function body.
