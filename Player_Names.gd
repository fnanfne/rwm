extends GridContainer

var font = FontFile.new()
var player_list_with_pos = []

# Called when the node enters the scene tree for the first time.
func _ready():
	#Font data and outline color, and size
	font.font_data = load("res://Assets/Fonts/Commodore_Angled_v1-1.ttf")
	font.outline_size = 2
	font.outline_color = Color("#000000")
	#Retrieves the scores. Number 0 means ALL scores will be retrieved. 5 means only the last 5 etc etc.
	await SilentWolf.Scores.get_high_scores(0).sw_scores_received
	#player_list_with_pos = sort_players_and_add_position(SilentWolf.Scores.scores)
	player_list_with_pos = sort_players_and_add_position()
	add_player_to_grid(player_list_with_pos)


func add_player_to_grid(player_list):
	var pos_vbox = VBoxContainer.new()
	var name_vbox = VBoxContainer.new()
	var score_vbox = VBoxContainer.new()
	
	for score_data in player_list_with_pos:
		var pos_label = Label.new()
		pos_label.add_theme_font_override("font", font)
		pos_label.text = str(score_data["position"])
		pos_label.show()
		pos_vbox.add_child(pos_label)
	add_child(pos_vbox)
	
	for score_data in player_list_with_pos:
		var name_label = Label.new()
		name_label.add_theme_font_override("font", font)
		name_label.text = str(score_data["player_name"])
		name_label.show()
		name_vbox.add_child(name_label)
	add_child(name_vbox)
	
	for score_data in player_list_with_pos:
		var score_label = Label.new()
		score_label.add_theme_font_override("font", font)
		score_label.text = str(score_data["score"])
		score_label.show()
		score_vbox.add_child(score_label)
	add_child(score_vbox)


func sort_players_and_add_position():
	player_list.sort_custom(CustomComparator, "sort_descending")
	var position = 1
	for player in player_list:
		player["position"] = position
		position += 1
	return player_list


class CustomComparator:
	#This just sorts the list
	static func sort_descending(a, b):
		if a["score"] > b["score"]:
			return true
		return false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
