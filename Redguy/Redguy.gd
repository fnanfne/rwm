extends CharacterBody2D

var SPEED = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var robot
var chase = false

func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	#Gravity for Redguy
	velocity.y += gravity * delta
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Walking")
		robot = get_node("../../Robot/Robot")
		var direction = (robot.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = false
		else:
			get_node("AnimatedSprite2D").flip_h = true
		velocity.x = direction.x * SPEED
	else:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Robot":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "Robot":
		chase = false

func _on_player_death_body_entered(body):
	if body.name == "Robot":
		#chase = false #made a function instead (death) below
		#get_node("AnimatedSprite2D").play("Death") #made a function instead (death) below
		#await get_node("AnimatedSprite2D").animation_finished #made a function instead (death) below
		#self.queue_free() #made a function instead (death) below
		death()

func _on_player_collision_body_entered(body):
	if body.name == "Robot":
		#body.health -= 3 # not needed anymore as it's now in the global Game script
		#Game.robotHP -= 3
		Game.lose_life()
		#chase = false #made a function instead (death) below
		#get_node("AnimatedSprite2D").play("Death") #made a function instead below
		#await get_node("AnimatedSprite2D").animation_finished #made a function instead below
		#self.queue_free() #
		death()

func death():
	Game.BTC += 5
	Utils.saveGame()
	chase = false
	#$CollisionShape2D.queue_free()
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
