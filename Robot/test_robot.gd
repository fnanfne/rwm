extends CharacterBody2D
class_name TestRobot
enum States {FALL = 1, FLOOR, LAUNCH, ZOOM, SHOOT, AUTO} # default numbering from 0, making air = 1 starts the numbering from one
var state = States.FALL

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim = get_node("AnimationPlayer")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	Game.TestRobotReference = self

func _physics_process(delta):
	# FALLING
	if not is_on_floor():
		velocity.y += gravity * delta
		anim.play("Fall")
		$AllSprites/Fall.visible = true
		$AllSprites/Wheel.visible = false
		$AllSprites/Idle.visible = false
		$AllSprites/Jump.visible = false
		$AllSprites/Run.visible = false
		$AllSprites/Shoot.visible = false
		$AllSprites/LaunchFire.visible = false
		$AllSprites/Launch.visible = false
		$AllSprites/AirShoot.visible = false
		$AllSprites/HelmetIdle.visible = false
		$AllSprites/HelmetRun.visible = false
		$AllSprites/HelmetJump.visible = false
		$AllSprites/HelmetLaunch.visible = false
		$AllSprites/HelmetIdleShoot.visible = false
		$AllSprites/HelmetFall.visible = false
	# ON THE GROUND
	else:
		$AllSprites/Idle.visible = true
		$AllSprites/Wheel.visible = true
		$AllSprites/Fall.visible = false
		$AllSprites/Jump.visible = false
		$AllSprites/Run.visible = false
		$AllSprites/Shoot.visible = false
		$AllSprites/LaunchFire.visible = false
		$AllSprites/Launch.visible = false
		$AllSprites/AirShoot.visible = false
		$AllSprites/HelmetIdle.visible = false
		$AllSprites/HelmetRun.visible = false
		$AllSprites/HelmetJump.visible = false
		$AllSprites/HelmetLaunch.visible = false
		$AllSprites/HelmetIdleShoot.visible = false
		$AllSprites/HelmetFall.visible = false
		anim.play("Idle")

	# JUMP.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		anim.play("Jump")
		velocity.y = JUMP_VELOCITY

	# MOVEMENT
	var direction = Input.get_axis("left", "right")
	if direction:
		anim.play("Run")
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
