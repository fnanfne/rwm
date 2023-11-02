extends Area2D


@export var text_field = ""


func _ready():
	$AnimationPlayer.stop()
	$MarginContainer/Panel.visible = false
	$MarginContainer/Label.text = text_field


func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Robots"):
		$MarginContainer/Panel.visible = true
		#print("TEXT SHOWING!")
		$AnimationPlayer.play("show")
		$RadioSound.play()


func _on_body_exited(body):
	if body.is_in_group("Robots"):
		$MarginContainer/Panel.visible = false
		$AnimationPlayer.stop()
