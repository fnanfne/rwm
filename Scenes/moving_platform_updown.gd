extends Node2D

@export var move_sequence_number : int = 1

@onready var anim = get_node("Platform/AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	match move_sequence_number:
		1:
			anim.play("move_loop_1")
		2:
			anim.play("move_loop_2")
		3:
			anim.play("move_loop_3")
		4:
			anim.play("move_loop_4")
