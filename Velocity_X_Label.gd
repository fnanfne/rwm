extends Label

func _process(_delta):
	text = "Vel X: " + str(Game.Robot.velocity.x)
