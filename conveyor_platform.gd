extends Area2D

var direction = 1

@export var speed = 500

func _ready():
	#velocity.x = speed
	pass

func _on_body_entered(body):
	if body.is_in_group("Robots"):
		body.velocity.x += speed * direction
		#print("Should now go!")

func reverse_conveyor():
	direction = direction * -1
