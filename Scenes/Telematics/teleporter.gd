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
	var TW1 = get_tree().create_tween()
	#TW1.tween_interval(5)
	TW1.tween_property($Node2D/On_Top, "modulate:a", 
	0.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	#TW1.tween_interval(8)
	TW1.tween_property($Node2D/On_Top, "modulate:a", 
	5.0, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	TW1.tween_property($Node2D/On_Top, "modulate:a",
	Color(1,1,1,1), 3)
	#TW1.tween_property($Sprite2D, "position", position - $Robot.get_node(position.x), 0.8)
