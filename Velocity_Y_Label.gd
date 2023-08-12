extends Label

func _process(_delta):
	text = "Vel Y: " + str(Game.Robot.velocity.y)
	#text = "Vel Y: " + str(get_parent().get_node())
