extends Node

var max_lives = 1
var robotHP = 0
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

func lose_life():
	robotHP -= 1
	hud.load_hearts()
