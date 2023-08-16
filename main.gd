extends Node2D


func _ready():
	#Utils.saveGame()
	Utils.loadGame()

func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/game_manager.tscn")
	Game.robotHP = 0
	Game.BTC = 0
