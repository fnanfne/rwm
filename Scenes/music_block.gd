extends Area2D

@export var song_beep : AudioStreamOggVorbis

@onready var music_blocks = get_tree().get_nodes_in_group("music_blocks")
var already_playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(music_blocks)
	pass


func _on_body_entered(body):
	if body.is_in_group("Robots"):
		#if already_playing == true or Game.is_music_playing:
		if Game.is_music_playing:
			for muzak in music_blocks:
				muzak.stop()
				print("HIIIII")
			print("SHOULD STOP!!")
			#already_playing = false
			Game.is_music_playing = false
		else:
			print("PLAYING NOW!!")
			$AudioStreamPlayer.stream = song_beep
			$AudioStreamPlayer.play()
			#already_playing = true
			Game.is_music_playing = true
		#print("ROBOT HERE")
		#$AudioStreamPlayer.stream = song_beep
		#$AudioStreamPlayer.play()
