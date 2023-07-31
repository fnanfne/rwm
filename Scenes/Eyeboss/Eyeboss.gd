extends CharacterBody2D

@export var enemy_death_effect : PackedScene

func _physics_process(_delta):
	pass



func _on_mouse_exited():
	print("HELLO!!!!")
	queue_free()
