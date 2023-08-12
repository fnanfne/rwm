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
