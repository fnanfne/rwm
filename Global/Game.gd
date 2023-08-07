extends Node

var max_lives = 1
var robotHP = clamp(0, 0, 9)
var healthContainers = 0
var BTC = 0
var hud
var JUMP = true
var DOUBLEJUMP = true
var HAXXOR = false
var HEMLET = false
var GUN = true
var LAUNCH = true
var ZOOM = true
var ANNIHILATE = false
var EXPLOZORZ = true
var VELCRO = false
var REDKEY = false
var BLUEKEY = false
var GREENKEY = false
var YELLOWKEY = false
var current_checkpoint : Checkpoint
var Robot : Robot

func lose_life():
	robotHP -= 1
	hud.load_hearts()

# I HAVE MOVED THE BELOW TO ROBOT INSTEAD
func respawn():
	if current_checkpoint != null:
		Robot.position = current_checkpoint.global_position
	else:
		Robot.position = Vector2(986,130)
