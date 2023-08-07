extends Node2D
class_name Checkpoint

@export var spawnpoint = false

var activated = false

func _ready():
	$Idle.show()
	
func _physics_process(_delta):
	if Game.current_checkpoint == self:
		$Idle.hide()
	else:
		$Idle.show()
		activated = false

func activate():
	$Activated2.play()
	activated = true
	#$Idle.hide()
	Game.current_checkpoint = self

func _on_area_2d_body_entered(body):
	if body.is_in_group("Robots"):
		if Game.robotHP != Game.healthContainers:
			Game.robotHP = Game.healthContainers
			$Activated2.play()
	if body.is_in_group("Robots") and !activated:
		activate()
