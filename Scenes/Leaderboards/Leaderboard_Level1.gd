@tool
extends Control

const ScoreItemL1 = preload("ScoreItemL1.tscn")
const SWLogger = preload("res://addons/silent_wolf/utils/SWLogger.gd")

var list_index = 0
# Replace the leaderboard name if you're not using the default leaderboard
var ld_name = "level1"
var max_scores = 10


func _ready():
	print("SilentWolf.Scores.leaderboards: " + str(SilentWolf.Scores.leaderboards))
	print("SilentWolf.Scores.ldboard_config: " + str(SilentWolf.Scores.ldboard_config))
	var scores = SilentWolf.Scores.scores
	#var scores = []
	if ld_name in SilentWolf.Scores.leaderboards:
		scores = SilentWolf.Scores.leaderboards[ld_name]
	var local_scores = SilentWolf.Scores.local_scores
	
	if len(scores) > 0: 
		render_board(scores, local_scores)
	else:
		# use a signal to notify when the high scores have been returned, and show a "loading" animation until it's the case...
		add_loading_scores_message()
		var sw_result = await SilentWolf.Scores.get_scores(0, "level1").sw_get_scores_complete
		scores = sw_result.scores
		hide_message()
		render_board(scores, local_scores)

	#await get_tree().create_timer(0.5).timeout
	#get_tree().reload_current_scene()

func render_board(scores: Array, local_scores: Array) -> void:
	var all_scores = scores
	if ld_name in SilentWolf.Scores.ldboard_config and is_default_leaderboard(SilentWolf.Scores.ldboard_config[ld_name]):
		all_scores = merge_scores_with_local_scores(scores, local_scores, max_scores)
		if scores.is_empty() and local_scores.is_empty():
			add_no_scores_message()
	else:
		if scores.is_empty():
			add_no_scores_message()
	if all_scores.is_empty():
		for score in scores:
			add_item(score.player_name, str(int(score.score)))#, str(Array(score.metadata.email)))
			#add_item(score.player_name, score.hours_value, score.minutes_value, score.seconds_value, score.milliseconds_value, str(int(score.score)))
	else:
		for score in all_scores:
			add_item(score.player_name, str(int(score.score)))#, str(Array(score.metadata.email)))
			#add_item(score.player_name, score.hours_value, score.minutes_value, score.seconds_value, score.milliseconds_value, str(int(score.score)))


func is_default_leaderboard(ld_config: Dictionary) -> bool:
	var default_insert_opt = (ld_config.insert_opt == "keep")
	var not_time_based = !("time_based" in ld_config)
	return default_insert_opt and not_time_based


func merge_scores_with_local_scores(scores: Array, local_scores: Array, max_scores: int=10) -> Array:
	if local_scores:
		for score in local_scores:
			var in_array = score_in_score_array(scores, score)
			if !in_array:
				scores.append(score)
			scores.sort_custom(sort_by_score);
	if scores.size() > max_scores:
		var new_size = scores.resize(max_scores)
	return scores


func sort_by_score(a: Dictionary, b: Dictionary) -> bool:
	if a.score > b.score:
		return true;
	else:
		if a.score < b.score:
			return false;
		else:
			return true;


func score_in_score_array(scores: Array, new_score: Dictionary) -> bool:
	var in_score_array =  false
	if !new_score.is_empty() and !scores.is_empty():
		for score in scores:
			if score.score_id == new_score.score_id: # score.player_name == new_score.player_name and score.score == new_score.score:
				in_score_array = true
	return in_score_array

func add_item(player_name: String, score_value: String) -> void:
#func add_item(player_name: String, score_value: String, hours_value: String, minutes_value: String, seconds_value: String, milliseconds_value: String) -> void:
	var item = ScoreItemL1.instantiate()
	list_index += 1
	item.get_node("HBoxContainer/PlayerNameContainer/PlayerName").text = str(list_index) + str(".") + player_name
	item.get_node("HBoxContainer/ScoreContainer/Score").text = score_value
	#item.get_node("Time/Hours").text = hours_value
	#item.get_node("Time/Minutes").text = minutes_value
	#item.get_node("Time/Seconds").text = seconds_value
	#item.get_node("Time/Milliseconds").text = milliseconds_value
	#item.get_node("Score2").text = time_value
	item.offset_top = list_index * 100
	$"Board/HighScores/ScoreItemContainer".add_child(item)


func add_no_scores_message() -> void:
	var item = $"Board/MessageContainer/TextMessage"
	item.text = "No scores yet!"
	$"Board/MessageContainer".show()
	item.offset_top = 135


func add_loading_scores_message() -> void:
	var item = $"Board/MessageContainer/TextMessage"
	item.text = "Loading scores..."
	$"Board/MessageContainer".show()
	item.offset_top = 135


func hide_message() -> void:
	$"Board/MessageContainer".hide()


func clear_leaderboard() -> void:
	var score_item_container = $"Board/HighScores/ScoreItemContainer"
	if score_item_container.get_child_count() > 0:
		var children = score_item_container.get_children()
		for c in children:
			score_item_container.remove_child(c)
			c.queue_free()


func _on_CloseButton_pressed() -> void:
	var scene_name = SilentWolf.scores_config.open_scene_on_close
	SWLogger.info("Closing SilentWolf leaderboard, switching to scene: " + str(scene_name))
	#global.reset()
	get_tree().change_scene_to_file(scene_name)


func _on_previous_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Leaderboards/Leaderboard_main.tscn")


func _on_button_pressed():
	get_tree().reload_current_scene()


func _on_test_adding_scores_pressed():
	if SilentWolf.Auth.logged_in_player == null:
		print("NO USER LOGGED!!")
	else:
		
		#var sw_result: Dictionary = await SilentWolf.Scores.save_score(player_name.text, player_score.text, "level1").sw_save_score_complete
		var player_name = SilentWolf.Auth.logged_in_player
		var score = 0
		var ldboard_name = "level1"
		var metadata = {
			"score_txt": "00:36:42:445"
  }
		SilentWolf.Scores.save_score(player_name, score, "level1", metadata)
		#print("Score saved successfully: " + str(sw_result.score_id))


func _on_test_viewing_metadata_pressed():
	
	if SilentWolf.Auth.logged_in_user == null:
		print("NO USER LOGGED IN!!!")
	else:
		var player_name = SilentWolf.Auth.logged_in_player
		var sw_result = await SilentWolf.Scores.get_scores_by_player(player_name).sw_get_player_scores_complete
		var scores = sw_result.scores
		print("Got player scores: " + str(sw_result.scores))
		print("Got: " + str(sw_result.scores.size()) + " scores for player: " + str(player_name))
		print("Does player have scores? " + str(sw_result.scores.size() > 0))
		print(player_name)
		for score in scores:
			print("Player name: " + str(player_name) + ", score: " + str(score.score) + ", metadata: " + str(score.metadata))


func _on_close_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
