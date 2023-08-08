extends Area2D

signal lever_turned()

# CREATE A DICTIONARY FOR ALL THE LEVER IMAGES
const TEXTURES: Dictionary = {
	'right': preload("res://Assets/Pics/right_lever.png"),
	'left': preload("res://Assets/Pics/left_lever.png")
}

var facing : int = 1

# ONREADY VAR FOR THE DOOR
#@onready var actionables_container: Node2D = get_parent().get_node("HaxxorDoor")
@onready var sprite: Sprite2D = get_node("Right")

func _ready():
	$Left.hide()

func _physics_process(_delta):
	#print(Game.PLATFORMDIRECTION)
	pass

func _on_body_entered(body):
	if body.is_in_group("Robots"):
		$Switched.play()
		lever_turned.emit()

func _on_lever_turned():
	if facing == 1:
		Game.PLATFORMDIRECTION = 2
		$Right.hide()
		$Left.show()
		facing = 2
	else:
		Game.PLATFORMDIRECTION = 1
		$Right.show()
		$Left.hide()
		facing = 1
