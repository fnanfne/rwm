extends Area2D

#export(NodePath) onready var target = get_node(target)

@export var target: Area2D

var is_ready_to_teleport = false
var teleporter_active = true
var player
var teleportState = 0
@onready var teleportLight = $Right/Telelight

func _on_body_entered(body):
	is_ready_to_teleport = true
	player = body
	$Telesizzle.play()
	var TW2 = get_tree().create_tween()
	var TW3 = get_tree().create_tween()
	#TW2.set_loops(0)
	TW2.tween_property($Right/Telelight, "modulate:a", 
	1.0, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	TW3.tween_property(player, "modulate:a", 
	0.0, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	TW2.tween_property($Right/Telelight, "modulate:a", 
	0.0, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	TW3.tween_property(player, "modulate:a", 
	1.0, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	#player.position = target.position
	$TimerTeleport2.start()
	

func _on_body_exited(_body):
	is_ready_to_teleport = false
	$Teleport.play()

func _physics_process(_delta):
	#if teleporter_active == true:
	#	if is_ready_to_teleport == true: # and Input.is_action_just_pressed("jump"):
	#		player.position = target.position
	#		#$TimerTeleport.start()
	#		$Teleport.play()
	pass

func _ready():
	var TW1 = get_tree().create_tween()
	TW1.set_loops(0)
	TW1.tween_property($Right/On_Right, "modulate:a", 
	0.6, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	#TW1.tween_interval(8)
	TW1.tween_property($Right/On_Right, "modulate:a", 
	1.0, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


#func teleport(): #Not really working
#	var TW2 = get_tree().create_tween()
	#TW2.set_loops(0)
	#TW2.tween_property($Right/Telelight, "modulate:a", 
	#0.6, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	#TW2.tween_property($Right/Telelight, "modulate:a", 
	#0.0, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	
	#match teleportState: # match is a better way to do multiple if's
	#	0: #this runs 0.3s after the timer starts
	#		TW2.tween_property($Right/Telelight, "modulate:a", 
	#		0.6, 0.15) #modulate the teleport_light 0-1
	#		$Teleport.play() #play sound of teleportation
	#	1: #this runs 0.6s after the timer starts
	#		target.position = target.position #move robot to target teleporter
	#		#move the camera to follow?
	#	2: #this runs 0.9s after the timer starts
	#		TW2.tween_property($Right/Telelight, "modulate:a", 
	#		0.6, 0.15) #modulate the teleport_light 1-0
	#	3: #this runs 1.2s after the timer starts
	#		#
	#		#
	#		pass
	#	4: #this runs 1.5s after the timer starts
	#		#
	#		$TimerTeleport.stop()
	#teleportState += 1
	


func _on_timer_teleport_2_timeout():
	player.position = target.position
	$TimerTeleport2.stop()
