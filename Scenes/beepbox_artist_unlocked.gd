extends Area2D

@export var beepbox_artist : int = 0
@export var beepbox_artist2 = ""

@onready var music_icon = get_node("AnimationPlayer3")
var beepbox_artist3

# Called when the node enters the scene tree for the first time.
func _ready():
	if Music.fnanfne == true:
		pass
	else :
		
		var rand_int = randi_range(0,2)
		match rand_int:
			0:
				$AnimatedSprite2D.play("blue")
			1:
				$AnimatedSprite2D.play("green")
			2:
				$AnimatedSprite2D.play("red")
		$AnimationPlayer.stop()
		$AnimationPlayer2.stop()
		$MarginContainer/Label.visible = false
		$Label.visible = false
		play_randomized("music_jiggle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Robots"):
		set_collision_mask_value(2,false)
		match beepbox_artist:
			1: 
				Music.aero = true
				$Label.text = "aero"
			2:
				Music.berrytheeveeboi = true
				$Label.text = "berrytheeveeboi"
			3:
				Music.bluedoggo123 = true
				$Label.text = "bluedoggo123"
			4:
				Music.clonedrone = true
				$Label.text = "clonedrone"
			5:
				Music.clorpdoop = true
				$Label.text = "clorpdoop"
			6:
				Music.choxolate = true
				$Label.text = "choxolate"
			7:
				Music.donutmaster56 = true
				$Label.text = "donutmaster56"
			8:
				Music.draworigami = true
				$Label.text = "draworigami"
			9:
				Music.fomb = true
				$Label.text = "fomb"
			10:
				Music.fnanfne = true
				$Label.text = "fnanfne"
			11:
				Music.gameworm = true
				$Label.text = "gameworm"
			12:
				Music.gabriel_miel = true
				$Label.text = "gabriel_miel"
			13:
				Music.ian05 = true
				$Label.text = "ian05"
			14:
				Music.jadeanubis = true
				$Label.text = "jadeanubis"
			15:
				Music.linkandar = true
				$Label.text = "linkandar"
			16:
				Music.joachim_s = true
				$Label.text = "joachim_s"
			17:
				Music.koopaluigi = true
				$Label.text = "koopaluigi"
			18:
				Music.mastertrek = true
				$Label.text = "mastertrek"
			19:
				Music.mathboy = true
				$Label.text = "mathboy"
			20:
				Music.paisleypickle = true
				$Label.text = "paisleypickle"
			21:
				Music.syncmaster = true
				$Label.text = "syncmaster"
			22: 
				Music.profile0182983 = true
				$Label.text = "profile0182983"
			23:
				Music.redkitty7 = true
				$Label.text = "redkitty7"
			24:
				Music.rodentracer = true
				$Label.text = "rodentracer"
			25:
				Music.thetom = true
				$Label.text = "thetom"
			26:
				Music.yourmoveboyo = true
				$Label.text = "yourmoveboyo"
			27:
				Music.ysqys = true
				$Label.text = "ysqys"
			27:
				Music.dmd = true
				$Label.text = "dmd"
		$RadioSound.play()
		$AnimatedSprite2D.visible = false
		$MarginContainer/Label.visible = true
		$Label.visible = true
		$Timer.start()


func _on_timer_timeout():
	$AnimationPlayer.play("fade_away")
	$AnimationPlayer2.play("zoom_fade")


func play_randomized(music_jiggle : String):
	randomize()
	music_icon.play(music_jiggle)
	var offset : float = randf_range(0, music_icon.current_animation_length)
	music_icon.advance(offset)
