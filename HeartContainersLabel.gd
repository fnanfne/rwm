extends Label

func _process(_delta):
	text = "HP containers: " + str(Game.healthContainers) #str(get_node("../../Robot/Robot").health)
