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
	var TW2 = get_tree().create_tween()
	TW2.set_loops(0)
	TW2.tween_property($Right/Telelight, "modulate:a", 
	0.6, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

func _on_body_exited(_body):
	is_ready_to_teleport = false
	#$Teleport.play()

func _physics_process(_delta):
	if teleporter_active == true:
		if is_ready_to_teleport == true and Input.is_action_just_pressed("jump"):
			player.position = target.position
			$Teleport.play()

func _ready():
	var TW1 = get_tree().create_tween()
	TW1.set_loops(0)
	TW1.tween_property($Right/On_Right, "modulate:a", 
	0.6, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	#TW1.tween_interval(8)
	TW1.tween_property($Right/On_Right, "modulate:a", 
	1.0, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
