extends Control

@onready var milliseconds = $LineEdit
var seconds = 0.0 #milliseconds / 1000
var minutes = 0 # seconds / 60

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Clock.text = minutes
