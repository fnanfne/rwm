extends Label

func _process(_delta):
	text = "State: " + str(Game.Robot.state)
