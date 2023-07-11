extends CanvasLayer

var Bitcoins = 0

func _ready():
	#$Panel/BTC.text = str(Game.BTC)
	$Panel/BTC.text = str(Bitcoins)


func _on_btc_collected():
	Bitcoins = Bitcoins + 1
	_ready()
