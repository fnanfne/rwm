extends Node2D

@onready var player_name = $ColorRect/PlayerName
@onready var player_score = $ColorRect/PlayerScore



func _ready():
	#Utils.saveGame()
	Utils.loadGame()


func _physics_process(_delta):
	# SILENTWOLF --> ONLINE LEADERBOARD
	score()
	#print(player_name.text)
	#print(player_score.text)


func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Levels/maze_runner_-_godot.tscn")
	Game.robotHP = 0
	Game.BTC = 0


# SILENTWOLF --> ONLINE LEADERBOARD
func _on_increase_pressed():
	Game.score += 10


# SILENTWOLF --> ONLINE LEADERBOARD
func _on_decrease_pressed():
	if Game.score > 0:
		Game.score -= 10


# SILENTWOLF --> ONLINE LEADERBOARD
func _on_submit_pressed():
	#$Player_Name.show()
	print(Game.score)
	#if Game.close_menu == true:
	if Game.score == 0:
		#var sw_result: Dictionary = await SilentWolf.Scores.save_score(Game.player_name, Game.score).sw_save_score_complete
		var sw_result: Dictionary = await SilentWolf.Scores.save_score(player_name.text, String(player_score.text), "level1").sw_save_score_complete
		print("Score saved successfully: " + str(sw_result.score_id))
		#SilentWolf.Scores.save_score(player_name.text, player_score.text).sw_save_score_complete


# SILENTWOLF --> ONLINE LEADERBOARD
func score():
	#$Score.text = "Score: " + str(Game.score)
	pass


func _on_leaderboard_pressed():
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	print("Scores: " + str(sw_result.scores))
	get_tree().change_scene_to_file("res://leaderboard.tscn")




func _on_test_pressed():
	var player_name = SilentWolf.Auth.logged_in_player
	var score = 451
	var ldboard_name = "level1"
	var metadata = {
		"score_txt": "00:36:42:445",
		"won_boss_fight": true
		}

	if SilentWolf.Auth.logged_in_player == null:
		print("NO USER LOGGED!!")
	else:
		SilentWolf.Scores.save_score(player_name, score, ldboard_name, metadata)
		print("Player email: " + str(score.metadata.score_txt))
