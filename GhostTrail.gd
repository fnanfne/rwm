extends Sprite2D

func _ready():
	var TW1 = get_tree().create_tween()
	TW1.set_loops(0)
	TW1.tween_property($GhostTrail, "modulate:a", 
	0.6, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	TW1.tween_property($GhostTrail, "modulate:a", 
	1.0, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
