extends Node

var max_lives = 1
var robotHP = clamp(0, 0, 9)
var healthContainers = 0
var BTC = 0
var YELLOWKEYS = 0
var CRYSTALS : int = 0 # same as above? 'int' not required
var hud
var JUMP = false
var DOUBLEJUMP = false
var HAXXOR = false
var HEMLET = false
var GUN = false
var LAUNCH = false
var ZOOM = false
var ANNIHILATE = false
var EXPLOZORZ = false
var VELCRO = false
var REDKEY = false
var BLUEKEY = false
var GREENKEY = false
var PUSHBLOCK = false
var current_checkpoint : Checkpoint
var Robot : Robot
var TestRobotReference : TestRobot
var PLATFORMDIRECTION : int = 1
var starting_position : = Vector2 (4060,1890)
var camera : Camera2D
var close_menu = false
var score = 0
var player_name = ""
var player_email = ""
var player_list = []
var is_music_playing = false


# SAVE SYSTEM
#var starting_position : = Vector2 (460,710)
#var xPos = 460
#var yPos = 710
#var data = {}
#const SAVE_FILE = "user://savefile.dat"


#func _ready():
#	load_data()


#func load_data():
#	if not FileAccess.file_exists(SAVE_FILE):
#		data = {
#			"xPos" = 460,
#			"yPos" = 710,
#		}
#		save_data()
#	var file =FileAccess.open(SAVE_FILE, FileAccess.READ)
#	data = file.get_var()
#	xPos = data.xPos
#	yPos = data.yPos
#	file = null


#func save_data():
#	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
#	data = {
#		"xPos" = xPos,
#		"yPos" = yPos,
#	}
#	file.store_var(data)
#	file = null
#


# I HAVE MOVED THE BELOW TO ROBOT INSTEAD
#func respawn():
#	if current_checkpoint != null:
#		Robot.position = current_checkpoint.global_position
#	else:
#		Robot.position = Vector2(986,130)


func lose_life():
	robotHP -= 1
	hud.load_hearts()


# SILENTWOLF --> ONLINE LEADERBOARD
func _ready():
	SilentWolf.configure({
		"api_key": "udPADbqpQV23AnuiKHQ8A6GdQyvPc1ht8oC6th99",
		"game_id": "robotwantskitty",
		"game_version": "1",
		"log_level": 1
	})
	
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://main.tscn"
		#"open_scene_on_close": "res://Scenes/main_menu.tscn"
	})


# SILENTWOLF --> ONLINE LEADERBOARD
func _physics_process(_delta):
	leaderboard()


# SILENTWOLF --> ONLINE LEADERBOARD
func leaderboard():
	# Changed to score5 due to a console error, line 31
	for scores in Game.score:
		Game.player_list.append(Game.player_name)
