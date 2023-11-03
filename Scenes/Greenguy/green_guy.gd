extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# ALWAYS LOOKING AT ROBOT	
	if Game.Robot.global_position.x > global_position.x:
		$Head.flip_h = true
		$Feelers.flip_h = true
		$Arms.flip_h = true
	else:
		$Head.flip_h = false
		$Feelers.flip_h = false
		$Arms.flip_h = false


func _on_body_entered(body):
	
	# DAMAGE ROBOT
	if body.is_in_group("Robots"):
		body.taking_damage()
