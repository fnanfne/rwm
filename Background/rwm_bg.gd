extends ParallaxBackground

var scrolling_speed = 10 #50 #This apparently does not work or not being used anywhere??

func _process(delta):
	scroll_offset.x -= scrolling_speed * delta
