extends CanvasLayer

@onready var textbox_container = $TextboxContainer
@onready var X_velocity_label = $TextboxContainer/MarginContainer/Panel/VBoxContainer/Label
@onready var Y_velocity_label = $TextboxContainer/MarginContainer/Panel/VBoxContainer/Label2
@onready var gravity_label = $TextboxContainer/MarginContainer/Panel/VBoxContainer/Label3

func _ready():
	#hide_debug_window()
	#show_debug_window()
	
func hide_debug_window():
	textbox_container.hide()
	
func show_debug_window():
	if Input.is_action_pressed("debug_window"):
		textbox_container.show()
