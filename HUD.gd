extends CanvasLayer

var Bitcoins = 0

func _ready():
	#$Panel/BTC.text = str(Game.BTC)
	$Panel/BTC.text = str(Bitcoins)
	load_hearts()
	Game.hud = self


func _on_btc_collected():
	Bitcoins = Bitcoins + 1
	_ready()

func load_hearts():
	$Panel/HeartFull.size.x = Game.robotHP * 36
	#$Panel/HeartEmpty.size.x = Game.robotHP * 36
	$Panel/HeartEmpty.size.x = (Game.max_lives - Game.robotHP) * 36
	$Panel/HeartEmpty.position.x = $Panel/HeartFull.position.x + $Panel/HeartFull.size.x * $Panel/HeartFull.scale.x
