extends "res://ui/screens/ScreenBase.gd"

signal update_history(count)
signal edit_card(question, answer, card, card_properties, update_deck)

var _hits : int = 0
var _registered_array : Array
var _study_array : Array

func start() -> void:
	pass

func start_study_array(var _type : String, var _card_limit : int) -> void:
	#print("We need to finish the start_study_array in PRACTICE OPTION BASE")
	_congrats_suporter(false)
	_study_array = []
	_registered_array = []
	
	match _type:
		"CUSTOM":
			pass
		"DAILY":
			_daily_study(_card_limit)
	
	print("The array has " + str(_study_array.size()) + " Cards and the Card limit is " + str(_card_limit))
	start()

func _custom_study(var _card_limit : int) -> void:
	pass

func _daily_study(var _card_limit : int) -> void:
	print("We should test this with each practice option")
	var _new_cards_studied_query : String = "SELECT new_cards_studied FROM Deck_History WHERE Deck_History.date = " + str(CARDCULATIONS.today_date) + " AND Deck_History.deck_id = " + str(USERDATA.current_deck_data["deck_id"])
	var _new_cards_studied_result : int = 0
	
	if USERDATA.get_by_query(_new_cards_studied_query):
		_new_cards_studied_result = USERDATA.get_by_query(_new_cards_studied_query)[0]["new_cards_studied"]
	
	#base#
	var _cards : Array = USERDATA.current_deck_data["cards"]
	
	var _new_cards : Array
	var _new_cards_limit : int = USERDATA.current_deck_data["settings"]["new_cards_per_day"] - _new_cards_studied_result
	
	var _review_cards : Array
	var _today_date : int = CARDCULATIONS.today_date
	
	var _else_cards : Array
	
	for _c in _cards:
		if _c["last_session"]:
			var _next_session : int = _c["last_session"] + _c["space_btwn_sessions"] * CARDCULATIONS.UNIX_DAY
			if _today_date >= _next_session:
				_review_cards.append(_c)
			else:
				_else_cards.append(_c)
		else:
			if _new_cards.size() < _new_cards_limit:
				_new_cards.append(_c)
			else:
				_else_cards.append(_c)
	
	for _c in _review_cards:
		_study_array.append(_c)
	
	for _c in _new_cards:
		_study_array.append(_c)
	
	_study_array.shuffle()
	
	if _study_array.size() > _card_limit:
		var _diference : int = _study_array.size() - _card_limit
		
		for _d in range(0, _diference):
			_study_array.pop_back()
	elif _study_array.size() == _card_limit:
		pass
	else:
		var _diference : int = _card_limit - _study_array.size()
		
		_else_cards.shuffle()
		for _d in range(0, _diference):
			_study_array.append(_else_cards.pop_back())
	
	_registered_array = _study_array.duplicate()

func _submit_answer(var _card : Dictionary, var _result : String) -> Dictionary:
	var _updated_card : Dictionary
	
	if _card:
		var _today_date : int = CARDCULATIONS.today_date
		
		match _result:
			"CORRECT":
				print("CORRECT")
				var _card_status : String
				if _card["last_session"]:
					if _card["last_session"] != _today_date:
						_card_status = "DUE"
				else:
					_card_status = "NEW"
				if _card_status:
					emit_signal("update_history", _card_status)
				
				if _today_date != _card["last_session"]:
					_card["space_btwn_sessions"] = _card["space_btwn_sessions"] + 1
				_card["hits"] = _card["hits"] + 1
				
				_card["last_session"] = _today_date
			"WRONG":
				print("WRONG")
				if _today_date != _card["last_session"]:
					_card["space_btwn_sessions"] = 0
				_card["fails"] = _card["fails"] + 1
		
		_updated_card = _card
	
	var _commit_card : Dictionary = _updated_card.duplicate()
# warning-ignore:return_value_discarded
	_commit_card.erase("answer")
# warning-ignore:return_value_discarded
	_commit_card.erase("question")
	emit_signal("edit_card", Dictionary(), Dictionary(), _commit_card, true, false)
	
	return _updated_card
