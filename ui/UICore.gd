extends Control

#UICore is the script that change scenes and shows/hides popup's

onready var _ui_side_bar = $Layout/UISideBar as Control

onready var _home = $Layout/Screens/Home as Control
onready var _card_creator = $Layout/Screens/CardCreator as Control

onready var _action_pop_up = $ActionPopUp as Control
onready var _shadow = $Shadow as Control
onready var _selector_rect = $SelectorRect as Control
onready var _new_deck_pop_up = $NewDeckPopUp as Control
onready var _change_deck_pop_up = $ChangeDeckPopUp as Control

onready var _current_screen : Control = _home


func _ready() -> void:
	_ui_side_bar.connect("go_to_home_screen_requested", self, "_on_home_requested")
	_ui_side_bar.connect("show_action_pop_up_requested", self, "_on_show_action_pop_up_requested")
	_ui_side_bar.connect("go_to_deck_screen_requested", self, "_on_deck_requested")
	_ui_side_bar.connect("go_to_practice_screen_requested", self, "_on_practice_requested")
	_ui_side_bar.connect("go_to_statistics_screen_requested", self, "_on_statistics_requested")
	_ui_side_bar.connect("go_to_settings_screen_requested", self, "_on_settings_requested")
	
	_action_pop_up.connect("go_to_new_card_screen_requested", self, "_on_new_card_requested")
	_action_pop_up.connect("go_to_new_deck_pop_up_requested", self, "_on_new_deck_pop_up_requested")
	_action_pop_up.connect("hide_action_pop_up_requested", self, "_on_hide_action_pop_up_requested")
	
	_new_deck_pop_up.connect("new_deck", self, "_on_commit_new_deck")
	_new_deck_pop_up.connect("hide_new_deck_pop_up_requested", self, "_on_hide_new_deck_pop_up_requested")
	
	_change_deck_pop_up.connect("change_current_deck", self, "_on_change_current_deck")
	_change_deck_pop_up.connect("hide_change_deck_pop_up_requested", self, "_on_hide_change_deck_pop_up_requested")
	
	_home.connect("go_to_deck_screen_requested", self, "_on_deck_requested")
	_home.connect("go_to_practice_screen_requested", self, "_on_practice_requested")
	
	_card_creator.connect("change_deck_requested", self, "_on_change_deck_requested")
	_card_creator.connect("new_card", self, "_on_commit_new_card")

func _change_screen(_screen : String) -> void:
	_selector_rect.go_to(_screen)
	match _screen:
		'HOME':
			print('H')
		'DECK':
			print('D')
		'PRACTICE':
			print('P')
		'STATS':
			print('ST')
		'SETTINGS':
			print('SE')

func _on_new_card_requested(_deck : Control) -> void:
	if _action_pop_up.showed: 
		_action_pop_up.animation_player.play("HIDE")

func _on_new_deck_pop_up_requested()-> void:
	if not _new_deck_pop_up.showed:
		_new_deck_pop_up.animation_player.play("SHOW")
		_shadow.animation_player.play("SHOW")
		#if _action_pop_up.showed: 
		#	_action_pop_up.animation_player.play("HIDE")

func _on_commit_new_deck(_title : String) -> void:
	if _new_deck_pop_up.showed:
		_new_deck_pop_up.animation_player.play("HIDE")
		_shadow.animation_player.play("HIDE")
		var _deck_dict : Dictionary = {
			"user_id" : 1,
			"title" : _title,
		}
		USERDATA.commit_data("Deck", _deck_dict)
		_home.start()

func _on_commit_new_card(_question : Dictionary, _answer : Dictionary, _deck_id : int) -> void:
	USERDATA.commit_data("Question", _question)
	USERDATA.commit_data("Answer", _answer)
	
	USERDATA.turn_("ON")
	var _q_q : String = "SELECT Question.question_id FROM Question"
	var _question_id : int = USERDATA.get_by_query(_q_q).pop_back()["question_id"]
	
	var _a_q : String = "SELECT Answer.answer_id FROM Answer"
	var _answer_id : int = USERDATA.get_by_query(_a_q).pop_back()["answer_id"]
	USERDATA.turn_("OFF")
	
	var _card_dict : Dictionary = {
		"deck_id": _deck_id,
		"question_id": _question_id,
		"answer_id": _answer_id,
	}
	USERDATA.commit_data("Card", _card_dict)
	_card_creator.start()

func _on_show_action_pop_up_requested() -> void:
	_change_screen("HOME")
	if not _action_pop_up.showed: 
		_action_pop_up.animation_player.play("SHOW")

func _on_hide_action_pop_up_requested() -> void:
	if _action_pop_up.showed: 
		_action_pop_up.animation_player.play("HIDE")

func _on_hide_new_deck_pop_up_requested() -> void:
	if _new_deck_pop_up.showed:
		_new_deck_pop_up.animation_player.play("HIDE")
		_shadow.animation_player.play("HIDE")

func _on_home_requested() -> void:
	_change_screen("HOME")

func _on_deck_requested(_deck : Control) -> void:
	_change_screen("DECK")

func _on_practice_requested(_deck : Control) -> void:
	_change_screen("PRACTICE")

func _on_statistics_requested(_deck : Control) -> void:
	_change_screen("STATS")

func _on_settings_requested(_deck : Control) -> void:
	_change_screen("SETTINGS")

func _on_change_deck_requested(_button : Control) -> void:
	if not _change_deck_pop_up.showed:
		_change_deck_pop_up.animation_player.play("SHOW")
		_shadow.animation_player.play("SHOW")

func _on_change_current_deck(_deck_id : int) -> void:
	if _change_deck_pop_up.showed:
		_change_deck_pop_up.animation_player.play("HIDE")
		_shadow.animation_player.play("HIDE")
		USERDATA.set_current_deck_data(_deck_id)
		_card_creator.start()
		_change_deck_pop_up.start()

func _on_hide_change_deck_pop_up_requested() -> void:
	if _change_deck_pop_up.showed:
		_change_deck_pop_up.animation_player.play("HIDE")
		_shadow.animation_player.play("HIDE")
