extends Node

var max_lives = 9
var robotHP = 0
var BTC = 0
var hud
var JUMP = true
var DOUBLEJUMP = true
var HAXXOR = false
var HEMLET = false
var GUN = true
var LAUNCH = true
var ZOOM = false
var ANNIHILATE = false
var EXPLOZORZ = false
var VELCRO = false
var REDKEY = false
var BLUEKEY = false
var GREENKEY = false
var YELLOWKEY = false

func lose_life():
	robotHP -= 1
	hud.load_hearts()
