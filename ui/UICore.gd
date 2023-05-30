extends Control

#UICore is the script that change scenes and shows/hides popup's

onready var _ui_side_bar = $Layout/UISideBar as Control

onready var _screens_node = $Layout/Screens as Control

onready var _home = $Layout/Screens/Home as Control
onready var _card_creator = $Layout/Screens/CardCreator as Control
onready var _decks = $Layout/Screens/Decks as Control
onready var _practice = $Layout/Screens/Practice as Control
onready var _flash_card_practice = $Layout/Screens/FlashCardPractice as Control
onready var _test_practice = $Layout/Screens/TestPractice as Control
onready var _deck_settings = $Layout/Screens/DeckSettings as Control

onready var _action_pop_up = $ActionPopUp as Control
onready var _shadow = $Shadow as Control
onready var _selector_rect = $SelectorRect as Control
onready var _new_deck_pop_up = $NewDeckPopUp as Control
onready var _change_deck_pop_up = $ChangeDeckPopUp as Control
onready var _select_type_study_pop_up = $SelectTypeStudyPopUp as Control

onready var _current_screen : Control = _home

func _ready() -> void:
	#CONNECT SIGNALS: CHANGE SCREENS
	_ui_side_bar.connect("go_to_home_screen_requested", self, "_on_home_requested")
	_action_pop_up.connect("go_to_new_card_screen_requested", self, "_on_card_creator_requested")
	_decks.connect("go_to_new_card_screen_requested", self, "_on_card_creator_requested")
	_ui_side_bar.connect("go_to_deck_screen_requested", self, "_on_deck_requested")
	_home.connect("go_to_deck_screen_requested", self, "_on_deck_requested")
	_card_creator.connect("go_to_deck_screen_requested", self, "_on_deck_requested")
	_home.connect("go_to_practice_screen_requested", self, "_on_practice_requested")
	_decks.connect("go_to_practice_screen_requested", self, "_on_practice_requested")
	_ui_side_bar.connect("go_to_practice_screen_requested", self, "_on_practice_requested")
	_select_type_study_pop_up.connect("go_to_flash_card_practice_requested", self, "_on_flash_card_practice_requested")
	_select_type_study_pop_up.connect("go_to_test_practice_requested", self, "_on_test_practice_requested")
	_select_type_study_pop_up.connect("go_to_memory_practice_requested", self, "_on_memory_practice_requested")
	_ui_side_bar.connect("go_to_statistics_screen_requested", self, "_on_statistics_requested")
	_ui_side_bar.connect("go_to_settings_screen_requested", self, "_on_settings_requested")
	
	#CONNECT SIGNALS: SHOW AND HIDE POP UPS 
	_action_pop_up.connect("go_to_new_deck_pop_up_requested", self, "_on_show_new_deck_pop_up_requested")
	_new_deck_pop_up.connect("hide_new_deck_pop_up_requested", self, "_on_hide_new_deck_pop_up_requested")
	_ui_side_bar.connect("show_action_pop_up_requested", self, "_on_show_action_pop_up_requested")
	_action_pop_up.connect("hide_action_pop_up_requested", self, "_on_hide_action_pop_up_requested")
	_card_creator.connect("change_deck_requested", self, "_on_show_change_deck_pop_up_requested")
	_decks.connect("change_deck_requested", self, "_on_show_change_deck_pop_up_requested")
	_practice.connect("change_deck_requested", self, "_on_show_change_deck_pop_up_requested")
	_practice.connect("show_select_type_study_pop_up", self, "_on_show_select_type_study_pop_up_requested")
	_select_type_study_pop_up.connect("hide_select_type_study_pop_up_requested", self, "_on_hide_select_type_study_pop_up_requested")
	_change_deck_pop_up.connect("hide_change_deck_pop_up_requested", self, "_on_hide_change_deck_pop_up_requested")
	_change_deck_pop_up.connect("change_current_deck", self, "_on_change_current_deck_by_pop_up")
	
	#CONNECT SIGNALS: DATABASE CALLS AND COMMITS
	_new_deck_pop_up.connect("new_deck", self, "_on_commit_new_deck")
	_card_creator.connect("new_card", self, "_on_commit_new_card")
	_card_creator.connect("edit_card", self, "_on_commit_edit_card")
	_flash_card_practice.connect("edit_card", self, "_on_commit_edit_card")
	_flash_card_practice.connect("update_history", self, "_on_commit_update_history")
	_test_practice.connect("edit_card", self, "_on_commit_edit_card")
	_test_practice.connect("update_history", self, "_on_commit_update_history")
	_card_creator.connect("update_history", self, "_on_commit_update_history")
	_card_creator.connect("delete_card", self, "_on_commit_delete_card")

func _restart() -> void:
	_home.start()
	_card_creator.start()
	_decks.start()
	_change_deck_pop_up.start()
	_practice.start()

func _change_screen(var _screen : String) -> void:
	for _s in _screens_node.get_children(): #Probably temporally
		_s.visible = false
	
	_selector_rect.go_to(_screen)
	
	match _screen:
		'HOME':
			_home.start()
			_home.visible = true #Probably temporally
		'CARD':
			_card_creator.start() #Only Card_creator do a start() here
			_card_creator.visible = true #Probably temporally
		'DECK':
			_decks.visible = true #Probably temporally
		'PRACTICE':
			_practice.visible = true #Probably temporally
		'FLASH_CARD':
			_flash_card_practice.visible = true #Probably temporally
		'TEST':
			_test_practice.visible = true
		'STATS':
			print('ST')
		'DECK_SETTINGS':
			_deck_settings.visible = true

#DATABASE CALLS AND COMMITS
func _update_current_deck(var _deck_id : int) -> void:
	USERDATA.set_current_deck_data(_deck_id)
	
	_restart()

func _on_commit_new_deck(var _title : String) -> void:
	if _new_deck_pop_up.showed:
		_new_deck_pop_up.animation_player.play("HIDE")
		_shadow.animation_player.play("HIDE")
		var _deck_dict : Dictionary = {
			"user_id" : USERDATA.current_user,
			"title" : _title,
		}
		USERDATA.commit_data("Deck", _deck_dict)
		
		var _last_deck_query : String = "SELECT MAX(Deck.deck_id) FROM Deck"
		var _last_deck_id : int = USERDATA.get_by_query(_last_deck_query)[0]["MAX(Deck.deck_id)"]
		var _deck_set_dict : Dictionary = {
			"deck_id": _last_deck_id
		}
		
		USERDATA.commit_data("Deck_Settings", _deck_set_dict)
		USERDATA.set_basic_data()
		
		_restart()

func _on_commit_new_card(var _question : Dictionary, var _answer : Dictionary, var _deck_id : int) -> void:
	USERDATA.commit_data("Question", _question)
	USERDATA.commit_data("Answer", _answer)
	
	var _q_q : String = "SELECT Question.question_id FROM Question"
	var _question_id : int = USERDATA.get_by_query(_q_q).pop_back()["question_id"]
	
	var _a_q : String = "SELECT Answer.answer_id FROM Answer"
	var _answer_id : int = USERDATA.get_by_query(_a_q).pop_back()["answer_id"]
	
	var _card_dict : Dictionary = {
		"deck_id": _deck_id,
		"question_id": _question_id,
		"answer_id": _answer_id,
	}
	USERDATA.commit_data("Card", _card_dict)
	
	USERDATA.set_basic_data()
	
	_update_current_deck(_deck_id)

func _on_commit_edit_card(var _question : Dictionary, var _answer : Dictionary, var _card : Dictionary, var _card_properties : bool, var _update_deck : bool) -> void:
	if _answer:
		USERDATA.update_data("Answer", "answer_id = " + str(_card["answer"]["answer_id"]), _answer)
	if _question:
		USERDATA.update_data("Question", "question_id = " + str(_card["question"]["question_id"]), _question)
	if _card_properties:
		USERDATA.update_data("Card", "card_id = " + str(_card["card_id"]), _card)
	
	if _update_deck:
		_update_current_deck(_card["deck_id"])

func _on_commit_update_history(var _count_to_update : String) -> void:
	var _deck_id : int = USERDATA.current_deck_data["deck_id"]
	var _search_today_history_query : String = "SELECT * FROM Deck_History WHERE Deck_History.date = " + str(CARDCULATIONS.today_date) + " AND Deck_History.deck_id = " + str(_deck_id)
	var _search_today_history_result : Dictionary
	
	if USERDATA.get_by_query(_search_today_history_query):
		_search_today_history_result = USERDATA.get_by_query(_search_today_history_query)[0]
	
	var _due_count : int = 0
	var _new_count : int = 0
	var _add_count : int = 0
	
	match _count_to_update:
		"DUE":
			_due_count = 1
		"NEW":
			_new_count = 1
		"ADD":
			_add_count = 1
	
	if _search_today_history_result: 
		_search_today_history_result["new_cards_studied"] += _new_count
		_search_today_history_result["due_cards_studied"] += _due_count
		_search_today_history_result["new_cards_added"] += _add_count
		USERDATA.update_data("Deck_History", "deck_id = " + str(_deck_id) + " AND date = " + str(CARDCULATIONS.today_date), _search_today_history_result)
	else:
		var _deck_history_dict : Dictionary = {
			"deck_id": _deck_id,
			"date" : CARDCULATIONS.today_date,
			"new_cards_studied" : _new_count,
			"due_cards_studied" : _due_count,
			"new_cards_added" : _add_count
		}
		USERDATA.commit_data("Deck_History", _deck_history_dict)

func _on_commit_delete_card(var _card : Dictionary) -> void:
	USERDATA.delete_data("Answer", "answer_id = " + str(_card["answer"]["answer_id"]))
	USERDATA.delete_data("Question", "question_id = " + str(_card["question"]["question_id"]))
	USERDATA.delete_data("Card", "card_id = " +  str(_card["id"]))
	
	_update_current_deck(_card["deck_id"])

#CHANGE SCREENS
func _on_home_requested() -> void:
	_change_screen("HOME")

func _on_card_creator_requested(var _card : Dictionary) -> void:
	if _action_pop_up.showed: 
		_action_pop_up.animation_player.play("HIDE")
	
	if _card:
		_card_creator.status = "EDITOR"
		_card_creator.editable_card = _card
	else: 
		_card_creator.status = "CREATOR"
	
	_change_screen("CARD")

func _on_deck_requested(var _deck : Control) -> void:
	if _deck:
		_update_current_deck(_deck.id)
	_change_screen("DECK")

func _on_practice_requested(var _deck : Control) -> void:
	if _deck:
		_update_current_deck(_deck.id)
	_change_screen("PRACTICE")

func _on_flash_card_practice_requested(var _type : String, var _card_count : int ) -> void:
	if _select_type_study_pop_up.showed:
		_select_type_study_pop_up.animation_player.play("HIDE")
		_shadow.animation_player.play("HIDE")
	_change_screen("FLASH_CARD")
	_flash_card_practice.start_study_array(_type, _card_count)

func _on_test_practice_requested(var _type : String, var _card_count : int ) -> void:
	if _select_type_study_pop_up.showed:
		_select_type_study_pop_up.animation_player.play("HIDE")
		_shadow.animation_player.play("HIDE")
	_change_screen("TEST")
	_test_practice.start_study_array(_type, _card_count)

func _on_memory_practice_requested(var _type : String, var _card_count : int ) -> void:
	if _select_type_study_pop_up.showed:
		_select_type_study_pop_up.animation_player.play("HIDE")
		_shadow.animation_player.play("HIDE")

func _on_statistics_requested( var _deck : Control) -> void:
	_change_screen("STATS")

func _on_settings_requested( var _deck : Control) -> void:
	_change_screen("DECK_SETTINGS")

#SHOW AND HIDE POP UPS
func _on_show_new_deck_pop_up_requested()-> void:
	if not _new_deck_pop_up.showed:
		_new_deck_pop_up.animation_player.play("SHOW")
		_shadow.animation_player.play("SHOW")

func _on_hide_new_deck_pop_up_requested() -> void:
	if _new_deck_pop_up.showed:
		_new_deck_pop_up.animation_player.play("HIDE")
		_shadow.animation_player.play("HIDE")

func _on_show_change_deck_pop_up_requested(_button : Control) -> void:
	if not _change_deck_pop_up.showed:
		_change_deck_pop_up.animation_player.play("SHOW")
		_shadow.animation_player.play("SHOW")

func _on_hide_change_deck_pop_up_requested() -> void:
	if _change_deck_pop_up.showed:
		_change_deck_pop_up.animation_player.play("HIDE")
		_shadow.animation_player.play("HIDE")

func _on_change_current_deck_by_pop_up(_deck_id : int) -> void:
	if _change_deck_pop_up.showed:
		_change_deck_pop_up.animation_player.play("HIDE")
		_shadow.animation_player.play("HIDE")
		_update_current_deck(_deck_id)

func _on_show_action_pop_up_requested() -> void:
	_change_screen("HOME")
	if not _action_pop_up.showed: 
		_action_pop_up.animation_player.play("SHOW")

func _on_hide_action_pop_up_requested() -> void:
	if _action_pop_up.showed: 
		_action_pop_up.animation_player.play("HIDE")

func _on_show_select_type_study_pop_up_requested(var _option : Dictionary, var _scroll_pos : int) -> void:
	if not _select_type_study_pop_up.showed:
		_shadow.animation_player.play("SHOW")
		_select_type_study_pop_up.start(_option, _scroll_pos)

func _on_hide_select_type_study_pop_up_requested() -> void:
	if _select_type_study_pop_up.showed:
		_shadow.animation_player.play("HIDE")
		_select_type_study_pop_up.animation_player.play("HIDE")
