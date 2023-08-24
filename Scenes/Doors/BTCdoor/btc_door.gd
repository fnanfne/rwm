extends StaticBody2D

@export var btc_required : int = 7

var timer_already_running = false

signal all_btc_collected

func _physics_process(_delta):
	# OLD CODE BELOW, REPLACED WITH BETTER CODE!!
	#print($Timer.time_left)
	#if Game.BTC == btc_required:
	#	if  timer_already_running == true:
	#		pass
	#	else:
	#		timer_already_running = true
	#		$Timer.start()
	#		emit_signal("all_btc_collected")
	pass

func _on_all_btc_collected():
	#$Timer.start()
	pass

func _on_timer_timeout():
	#set_collision_mask_value(1,false) # NOT WORKING
	set_collision_layer_value(1,false)
	$DoorOpen.play()
	var TW1 = get_tree().create_tween()
	var TW2 = get_tree().create_tween()
	TW2.tween_property(self, "position", position - Vector2(80,0), 0.3)
	TW1.tween_property(self, "modulate:a", 0, 1.0)
	TW1.tween_callback(queue_free)
	#TW2.tween_callback(queue_free)

func open_btc_door():
	print("SIGNAL RECIEVED!!!!!!!!!!!")
	$Timer.start()
