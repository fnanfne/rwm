extends StaticBody2D

var speed = 100
var direction = 1

#@export var speed = 50
#@export var size : Rect2 = Rect2(0,0,400,40)

func _ready():
	constant_linear_velocity.x = speed

func _process(delta):
	#$Sprite2D.region_rect = size
	#print($Sprite2D.region_rect)
	#print(size)
	$Top.texture_repeat = 2
	$Bottom.texture_repeat = 2
	$Sprite2D.texture.region.position.x -= speed * direction * delta
	$Top.texture.region.position.x -= speed * direction * delta
	$Bottom.texture.region.position.x -= speed * direction * -1 * delta
