extends Area2D

var size_min = 1
var size_max = 1.1
var should_shrink = true
var rate = 0.005

func _ready():
	$AnimatedSprite2D.scale.x = 1
	$AnimatedSprite2D.scale.y = 1
	#var tween0 = get_tree().create_tween()
	#tween0.tween_property($AnimatedSprite2D, "scale", Vector2(1,1), Vector2(2,2),5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, 1.5)
	#tween0.interpolate_property($AnimatedSprite2D, "scale", Vector2(1,1), Vector2(2,2),5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, 1.5)

func _process(_delta):
	if should_shrink:
		_shrink(rate)
		if $AnimatedSprite2D.scale.x <= size_min:
			should_shrink = false
			
	if not should_shrink:
		_grow(rate)
		if $AnimatedSprite2D.scale.x >= size_max:
			should_shrink = true

func _shrink(amount):
	$AnimatedSprite2D.scale.x -= amount
	$AnimatedSprite2D.scale.y -= amount
	
func _grow(amount):
		$AnimatedSprite2D.scale.x += amount
		$AnimatedSprite2D.scale.y += amount

func _on_body_entered(body):
	if body.is_in_group("Robots"):
	#if body.name == "NewRobot":
		#$CollisionShape2D.queue_free()
		set_collision_mask_value(2,false)
		#Game.ANNIHILATE = true
		#ADD 10 SECONDS SAVE ON IGT
		$SoundPickup.play()
		body.app_pickup(5)
		var tween1 = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		tween1.tween_property(self, "position", position - Vector2(0,42), 0.5)
		tween2.tween_property(self, "modulate:a", 0, 0.5)
		tween1.tween_callback(queue_free)
		tween2.tween_callback(queue_free)
