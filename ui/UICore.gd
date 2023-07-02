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
onready var _card_stats = $Layout/Screens/CardStats as Control
onready var _deck_stats = $Layout/Screens/DeckStats as Control
onready var _card_list_stats = $Layout/Screens/CardListStats as Control
onready var _deck_settings = $Layout/Screens/DeckSettings as Control
onready var _user_settings = $Layout/Screens/UserSettings as Control

onready var _action_pop_up = $ActionPopUp as Control
onready var _shadow = $Shadow as Control
onready var _selector_rect = $SelectorRect as Control
onready var _new_deck_pop_up = $NewDeckPopUp as Control
onready var _change_deck_pop_up = $ChangeDeckPopUp as Control
onready var _select_type_study_pop_up = $SelectTypeStudyPopUp as Control

onready var _init_screen = $InitScreen as Control

onready var _log_in = $InitScreen/LogIn as Control
onready var _create_user = $InitScreen/CreateUser as Control

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
	_decks.connect("go_to_settings_screen_requested", self, "_on_deck_settings_requested" )
	_card_stats.connect("go_to_deck_stats", self, "_on_deck_stats_requested")
	_card_stats.connect("go_to_card_list_stats", self, "_on_card_list_stats")
	_deck_stats.connect("go_to_card_stats", self, "_on_statistics_requested")
	_deck_stats.connect("go_to_card_list_stats", self, "_on_card_list_stats")
	_card_list_stats.connect("go_to_card_stats", self, "_on_statistics_requested")
	_card_list_stats.connect("go_to_deck_stats", self, "_on_deck_stats_requested")
	_deck_settings.connect("go_to_user_settings_requested", self, "_on_user_settings_requested")
	_user_settings.connect("go_to_deck_settings_requested", self, "_on_deck_settings_requested")
	_user_settings.connect("go_to_log_in_requested", self, "_on_log_in_requested")
	_log_in.connect("go_to_create_user_screen_requested", self, "_on_create_user_requested")
	_create_user.connect("go_to_log_in_screen_requested", self, "_on_log_in_requested")
	_ui_side_bar.connect("go_to_practice_screen_requested", self, "_on_practice_requested")
	_select_type_study_pop_up.connect("go_to_flash_card_practice_requested", self, "_on_flash_card_practice_requested")
	_select_type_study_pop_up.connect("go_to_test_practice_requested", self, "_on_test_practice_requested")
	_select_type_study_pop_up.connect("go_to_memory_practice_requested", self, "_on_memory_practice_requested")
	_ui_side_bar.connect("go_to_statistics_screen_requested", self, "_on_statistics_requested")
	_decks.connect("go_to_statistics_screen_requested", self, "_on_statistics_requested")
	_ui_side_bar.connect("go_to_user_settings_screen_requested", self, "_on_user_settings_requested")
	_ui_side_bar.connect("go_to_deck_settings_screen_requested", self, "_on_deck_settings_requested")
	
	#CONNECT SIGNALS: SHOW AND HIDE POP UPS 
	_action_pop_up.connect("go_to_new_deck_pop_up_requested", self, "_on_show_new_deck_pop_up_requested")
	_new_deck_pop_up.connect("hide_new_deck_pop_up_requested", self, "_on_hide_new_deck_pop_up_requested")
	_ui_side_bar.connect("show_action_pop_up_requested", self, "_on_show_action_pop_up_requested")
	_action_pop_up.connect("hide_action_pop_up_requested", self, "_on_hide_action_pop_up_requested")
	_card_creator.connect("change_deck_requested", self, "_on_show_change_deck_pop_up_requested")
	_decks.connect("change_deck_requested", self, "_on_show_change_deck_pop_up_requested")
	_deck_settings.connect("change_deck_requested", self, "_on_show_change_deck_pop_up_requested")
	_practice.connect("change_deck_requested", self, "_on_show_change_deck_pop_up_requested")
	_card_stats.connect("change_deck_requested", self, "_on_show_change_deck_pop_up_requested")
	_deck_stats.connect("change_deck_requested", self, "_on_show_change_deck_pop_up_requested")
	_card_list_stats.connect("change_deck_requested", self, "_on_show_change_deck_pop_up_requested")
	_practice.connect("show_select_type_study_pop_up", self, "_on_show_select_type_study_pop_up_requested")
	_select_type_study_pop_up.connect("hide_select_type_study_pop_up_requested", self, "_on_hide_select_type_study_pop_up_requested")
	_change_deck_pop_up.connect("hide_change_deck_pop_up_requested", self, "_on_hide_change_deck_pop_up_requested")
	_change_deck_pop_up.connect("change_current_deck", self, "_on_change_current_deck_by_pop_up")
	_log_in.connect("user_entering", self, "_on_user_entering")
	
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
	_deck_settings.connect("edit_deck", self, "_on_commit_edit_deck")
	_deck_settings.connect("edit_deck_settings", self, "_on_commit_edit_deck_settings")
	_deck_settings.connect("delete_deck", self, "_on_commit_delete_deck")
	_user_settings.connect("edit_user", self, "_on_commit_edit_user")
	_user_settings.connect("delete_user", self, "_on_commit_delete_user")
	_create_user.connect("new_user", self, "_on_commit_new_user")

func _restart() -> void:
	_home.start()
	_card_creator.start()
	_decks.start()
	_change_deck_pop_up.start()
	_practice.start()
	_deck_settings.start()
	_card_stats.start()
	_deck_stats.start()
	_card_list_stats.start()

func _change_screen(var _screen : String) -> void:
	for _s in _screens_node.get_children(): #Probably temporally
		_s.visible = false
	for _i_s in _init_screen.get_children():
		_i_s.visible = false
	
	if _screen != "CREATE_USER" and _screen != "LOG_IN":
		_init_screen.visible = false
		_selector_rect.go_to(_screen)
	else:
		_init_screen.visible = true
	
	match _screen:
		'HOME':
			_home.start()
			_home.visible = true #Probably temporally
		'CARD':
			_card_creator.start() #Only Card_creator do a start() here
			_card_creator.visible = true #Probably temporally
		'DECK':
			_decks.start()
			_decks.visible = true #Probably temporally
		'PRACTICE':
			_practice.start()
			_practice.visible = true #Probably temporally
		'FLASH_CARD':
			_flash_card_practice.visible = true #Probably temporally
		'TEST':
			_test_practice.visible = true
		'STATS':
			_card_stats.start()
			_card_stats.visible = true
		'DECK_STATS':
			_deck_stats.start()
			_deck_stats.visible = true
		'CARD_LIST_STATS':
			_card_list_stats.start()
			_card_list_stats.visible = true
		'DECK_SETTINGS':
			_deck_settings.start()
			_deck_settings.visible = true
		"USER_SETTINGS":
			_user_settings.start()
			_user_settings.visible = true
		"CREATE_USER":
			_create_user.start()
			_create_user.visible = true
		"LOG_IN":
			_log_in.start()
			_log_in.visible = true

#DATABASE CALLS AND COMMITS
func _update_current_deck(var _deck_id : int) -> void:
	USERDATA.set_current_deck_data(_deck_id)
	
	_restart()

func _on_commit_new_user(var _new_user : Dictionary) -> void:
	USERDATA.commit_data("User", _new_user)

func _on_commit_edit_user(var _user_changes : Dictionary) -> void:
	USERDATA.update_data("User", "user_id = " + str(_user_changes["user_id"]), _user_changes)
	USERDATA.set_users_data()
	USERDATA.set_current_user_data()
	
	_restart()

func _on_commit_delete_user() -> void:
	_delete_all_decks()
	_delete_all_history()
	USERDATA.delete_data("User", "user_id = " + str(USERDATA.current_user))
	
	_restart()
	_change_screen("LOG_IN")

func _delete_all_decks() -> void:
	var _d_q : String = "SELECT Deck.deck_id, Deck.user_id, Deck.title, Deck.days_on_streak_record FROM Deck LEFT JOIN User ON Deck.user_id = User.user_id WHERE User.user_id = " + str(USERDATA.current_user)
	var _d_decks : Array = USERDATA.get_by_query(_d_q)
	
	for _d in _d_decks:
		_update_current_deck(_d["deck_id"])
		
		_on_commit_delete_deck(true)

func _delete_all_history() -> void:
	USERDATA.delete_data("Deck_History", "user_id = " + str(USERDATA.current_user))

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

func _on_commit_edit_deck(var _deck_changes : Dictionary) -> void:
	USERDATA.update_data("Deck", "deck_id = " + str(_deck_changes["deck_id"]), _deck_changes)
	
	USERDATA.set_basic_data()
	_update_current_deck(_deck_changes["deck_id"])
	
	_restart()

func _on_commit_edit_deck_settings(var _deck_settings_changes : Dictionary) -> void:
	USERDATA.update_data("Deck_Settings", "settings_id = " + str(_deck_settings_changes["settings_id"]), _deck_settings_changes)
	
	USERDATA.set_basic_data()
	_update_current_deck(_deck_settings_changes["deck_id"])
	
	_restart()

func _on_commit_delete_deck(var _delete_all : bool) -> void:
	_delete_all_cards()
	_delete_deck_setting()
	
	USERDATA.delete_data("Deck", "deck_id = " + str(USERDATA.current_deck_data["deck_id"]))
	USERDATA.current_deck_data = {}
	
	if _delete_all:
		pass
	else:
		_change_screen("HOME")

func _delete_all_cards()-> void:
	var _card_array : Array = USERDATA.current_deck_data["cards"]
	
	for _c in _card_array:
		_on_commit_delete_card(_c)

func _delete_deck_setting() -> void:
	USERDATA.delete_data("Deck_Settings", "deck_id = " + str(USERDATA.current_deck_data["deck_id"]))

func _on_commit_new_card(var _question : Dictionary, var _answer : Dictionary, var _deck_id : int) -> void:
	if _question.has("img_dir"):
		if _question["img_dir"] != "":
			_question["img_dir"] = MOVINGFILE.move_directory(_question["img_dir"])
	
	if _answer.has("img_dir"):
		if _answer["img_dir"] != "":
			_answer["img_dir"] = MOVINGFILE.move_directory(_answer["img_dir"])
	
	USERDATA.commit_data("Question", _question)
	USERDATA.commit_data("Answer", _answer)

	var _question_id : int = 0
	var _q_q : String = "SELECT Question.question_id FROM Question"
	_question_id = USERDATA.get_by_query(_q_q).pop_back()["question_id"]
	
	var _answer_id : int = 0
	var _a_q : String = "SELECT Answer.answer_id FROM Answer"
	_answer_id = USERDATA.get_by_query(_a_q).pop_back()["answer_id"]
	
	var _card_dict : Dictionary = {
		"deck_id": _deck_id,
		"question_id": _question_id,
		"answer_id": _answer_id,
	}
	
	USERDATA.commit_data("Card", _card_dict)
	
	_update_current_deck(_deck_id)

func _on_commit_edit_card(var _question : Dictionary, var _answer : Dictionary, var _card : Dictionary, var _card_properties : bool, var _update_deck : bool) -> void:
	if _answer:
		if _answer.has("img_dir"):
			if _answer["img_dir"] != "":
				_answer["img_dir"] = MOVINGFILE.move_directory(_answer["img_dir"])
			else: 
				var _q_a : String = "SELECT img_dir FROM Answer WHERE answer_id = " + str(_card["answer"]["answer_id"])
				var _img_dir : String = USERDATA.get_by_query(_q_a).pop_back()["img_dir"]
				
				MOVINGFILE.delete_file(_img_dir)
		
		USERDATA.update_data("Answer", "answer_id = " + str(_card["answer"]["answer_id"]), _answer)
	if _question:
		if _question.has("img_dir"):
			if _question["img_dir"] != "":
				_question["img_dir"] = MOVINGFILE.move_directory(_question["img_dir"])
			else:
				var _q_q : String = "SELECT img_dir FROM Question WHERE question_id = " + str(_card["question"]["question_id"])
				var _img_dir : String = USERDATA.get_by_query(_q_q).pop_back()["img_dir"]
				
				MOVINGFILE.delete_file(_img_dir)
		
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
			"user_id": USERDATA.current_user,
			"date" : CARDCULATIONS.today_date,
			"new_cards_studied" : _new_count,
			"due_cards_studied" : _due_count,
			"new_cards_added" : _add_count
		}
		USERDATA.commit_data("Deck_History", _deck_history_dict)

func _on_commit_delete_card(var _card : Dictionary) -> void:
	var _deck_id : int = _card["deck_id"]
	
	if _card["question"]["img_dir"] != "":
		var _q_q : String = "SELECT img_dir FROM Question WHERE question_id = " + str(_card["question"]["question_id"])
		var _img_dir : String = USERDATA.get_by_query(_q_q).pop_back()["img_dir"]
		
		MOVINGFILE.delete_file(_img_dir)
	
	if _card["answer"]["img_dir"] != "":
		var _q_a : String = "SELECT img_dir FROM Answer WHERE answer_id = " + str(_card["answer"]["answer_id"])
		var _img_dir : String = USERDATA.get_by_query(_q_a).pop_back()["img_dir"]
		
		MOVINGFILE.delete_file(_img_dir)
	
	USERDATA.delete_data("Answer", "answer_id = " + str(_card["answer"]["answer_id"]))
	USERDATA.delete_data("Question", "question_id = " + str(_card["question"]["question_id"]))
	USERDATA.delete_data("Card", "card_id = " +  str(_card["card_id"]))
	
	_update_current_deck(_deck_id)

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

func _on_deck_stats_requested(var _deck: Control) -> void:
	_change_screen("DECK_STATS")

func _on_card_list_stats(var _deck: Control )-> void:
	_change_screen("CARD_LIST_STATS")

func _on_deck_settings_requested( var _deck : Control) -> void:
	_change_screen("DECK_SETTINGS")

func _on_user_settings_requested(var _deck : Control) -> void:
	_change_screen("USER_SETTINGS")

func _on_create_user_requested(var _deck : Control) -> void:
	_change_screen("CREATE_USER")

func _on_log_in_requested(var _deck : Control) -> void:
	USERDATA.current_deck_data = {}
	_change_screen("LOG_IN")

#SHOW AND HIDE POP UPS
func _on_show_new_deck_pop_up_requested()-> void:
	if not _new_deck_pop_up.showed:
		_new_deck_pop_up.start()
		_new_deck_pop_up.animation_player.play("SHOW")
		_shadow.animation_player.play("SHOW")

func _on_hide_new_deck_pop_up_requested() -> void:
	if _new_deck_pop_up.showed:
		_new_deck_pop_up.animation_player.play("HIDE")
		_shadow.animation_player.play("HIDE")

func _on_show_change_deck_pop_up_requested(_button : Control) -> void:
	if not _change_deck_pop_up.showed:
		_change_deck_pop_up.animation_player.play("SHOW")
		_change_deck_pop_up.start()
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

func _on_user_entering(var _user_id: int) -> void:
	USERDATA.current_user = _user_id
	USERDATA.set_current_user_data()
	
	_restart()
	_change_screen("HOME")
