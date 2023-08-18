extends StaticBody2D

var speed = 75
var direction = 1

#@export var speed = 50
#@export var size : Rect2 = Rect2(0,0,400,40)

func _ready():
	constant_linear_velocity.x = speed

func _process(delta):
	#$Sprite2D.region_rect = size
	#print($Sprite2D.region_rect)
	#print(size)
	$Sprite2D.texture_repeat = 2
	#$Bottom.texture_repeat = 2
	$Sprite2D.texture.region.position.x -= speed * delta
	#$Top.texture.region.position.x -= speed * delta
	#$Bottom.texture.region.position.x -= speed * delta * -1

func _on_area_2d_body_entered(body):
	if body.is_in_group("Robots"):
		body.is_autobot = true
