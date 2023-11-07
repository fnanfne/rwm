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
		if Game.is_music_playing:
			pass
		else:
			for muzak in music_blocks:
				muzak.stop()
				print("ALL MUSIC SHOULD STOP!!!")
			Game.is_music_playing = false
			$Timer.start()


func _on_timer_timeout():
		$AudioStreamPlayer.stream = song_beep
		$AudioStreamPlayer.play()
		Game.is_music_playing = true
