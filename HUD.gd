extends CanvasLayer

var Bitcoins = 0

func _ready():
	pass
	#$Panel/BTC.text = str(Game.BTC)
	#$Panel/BTC.text = str(Bitcoins)
	#load_hearts()
	#Game.hud = self

func _physics_process(_delta):
	load_hearts()

#func _on_btc_collected():
#	Bitcoins = Bitcoins + 1
#	_ready()

func load_hearts():
	$Panel/HeartFull.size.x = Game.robotHP * 36
	#$Panel/HeartFull2.size.x = Game.robotHP * 53
	#$Panel/HeartEmpty2.size.x = Game.healthContainers * 53
	$Panel/HeartEmpty.size.x = Game.healthContainers * 36
	
	if Game.robotHP == 0:
		$Panel/HeartFull.hide()
		#$Panel/HeartFull2.hide()
	else:
		#$Panel/HeartFull.size.x = Game.robotHP * 36
		#$Panel/HeartFull2.size.x = Game.robotHP * 53
		$Panel/HeartFull.show()
		#$Panel/HeartFull2.show()

	if Game.healthContainers == 0:
		$Panel/HeartEmpty.hide()
		#$Panel/HeartEmpty2.hide()
	else:
		#$Panel/HeartEmpty2.size.x = Game.healthContainers * 53
		#$Panel/HeartEmpty.size.x = Game.healthContainers * 36
		$Panel/HeartEmpty.show()
		#$Panel/HeartEmpty2.show()
	#$Panel/HeartEmpty.size.x = (Game.max_lives - Game.robotHP) * 36
	#$Panel/HeartEmpty.position.x = $Panel/HeartFull.position.x + $Panel/HeartFull.size.x * $Panel/HeartFull.scale.x
	#$Panel/HeartEmpty.position.x = $Panel/HeartFull.position.x
