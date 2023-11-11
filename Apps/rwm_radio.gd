extends Area2D


func _ready():
	$RwM.visible = false


func _process(_delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Robots"):
		$RwM.visible = true
		$RadioSound.play()
		$Timer.start()


func _on_timer_timeout():
	$RwM.visible = false
