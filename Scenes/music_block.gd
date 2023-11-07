extends Area2D

@export var song_beep : AudioStreamOggVorbis

@onready var music_blocks = get_tree().get_nodes_in_group("music_blocks")
#var already_playing = false


func _on_body_entered(body):
	if body.is_in_group("Robots"):
		#if Game.is_music_playing:
		#	print("PASSING< NO CHANGE!!")
		#	pass
		#else:
		for muzak in music_blocks:
			muzak.stop()
			#print("ALL MUSIC SHOULD STOP!!!")
		#Game.is_music_playing = false
		$Timer.start()


func _on_timer_timeout():
		#print("NEW SONG SHOULD START!!")
		$AudioStreamPlayer.stream = song_beep
		$AudioStreamPlayer.play()
		#Game.is_music_playing = true
