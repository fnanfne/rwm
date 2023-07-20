extends Area2D

#export(NodePath) onready var target = get_node(target)

@export var target: Area2D

var is_ready_to_teleport = false
var teleporter_active = true
var player

func _on_body_entered(body):
	is_ready_to_teleport = true
	player = body
	$Telesizzle.play()


func _on_body_exited(_body):
	is_ready_to_teleport = false
	$Teleport.play()

func _physics_process(_delta):
	if teleporter_active == true:
		if is_ready_to_teleport == true and Input.is_action_just_pressed("jump"):
			player.position = target.position
