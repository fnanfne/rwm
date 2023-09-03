extends Panel

var time: float = 0.0
var hours: float = 0
var minutes: float = 0
var seconds: float = 0
var milliseconds: float = 0

var timer_paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	milliseconds = fmod(time, 1) * 1000
	seconds = fmod(time, 60)
	minutes = fmod(time, 60*60) / 60
	hours = fmod(fmod(time, 3600 * 60) / 3600,24)
	$HBoxContainer/Hours.text = "%02d" % hours
	$HBoxContainer/Minutes.text = "%02d" % minutes
	$HBoxContainer/Seconds.text = "%02d" % seconds
	$HBoxContainer/Milliseconds.text = "%03d" % milliseconds

func format_time() -> String:
	return "%02d:%02d:%02d.%03d:" % [hours, minutes, seconds, milliseconds]

func stop_timer():
	set_process(false)

func resume_timer():
	set_process(true)

func _on_pause_resume_pressed():
	if timer_paused == false:
		set_process(false)
		timer_paused = true
		$"../PauseResume".text = "resume"
	else:
		set_process(true)
		timer_paused = false
		$"../PauseResume".text = "pause"
