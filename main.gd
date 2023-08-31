extends Node2D


func _ready():
	#Utils.saveGame()
	Utils.loadGame()


func _physics_process(_delta):
	# SILENTWOLF --> ONLINE LEADERBOARD
	score()


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
	if Game.close_menu == true:
		var sw_result: Dictionary = await SilentWolf.Scores.save_score(Game.player_name, Game.score).sw_save_score_complete
		print("Score persisted successfully: " + str(sw_result.score_id))


# SILENTWOLF --> ONLINE LEADERBOARD
func score():
	#$Score.text = "Score: " + str(Game.score)
	pass


func _on_leaderboard_pressed():
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	print("Scores: " + str(sw_result.scores))
	get_tree().change_scene_to_file("res://leaderboard.tscn")
