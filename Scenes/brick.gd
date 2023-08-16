extends StaticBody2D

var crack_level = 0

@export var brick_break_effect : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if crack_level == 1:
		$Crack01.show()
	elif  crack_level == 2:
		$Crack02.show()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Robots") and Game.HEMLET == true:
		if crack_level == 2:
			set_collision_mask_value(2,false)
			$BrickBreak.play()
			var effect_instance : GPUParticles2D = brick_break_effect.instantiate()
			effect_instance.position = position
			effect_instance.emitting = true
			get_parent().add_child(effect_instance)
			var TW1 = get_tree().create_tween()
			TW1.tween_property(self, "modulate:a", 0, 0.2)
			await $BrickBreak.finished
			#TW1.tween_callback(queue_free)
			queue_free()
		else:
			$Bump.play()
			crack_level += 1
			
