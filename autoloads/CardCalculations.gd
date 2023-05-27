extends Node

const UNIX_DAY = 86400

onready var today_date = OS.get_unix_time() - OS.get_unix_time() % UNIX_DAY

func calculated_all_cards_count(_deck : Dictionary) -> int:
	var _cards : Array = _deck["cards"]
	var _cards_count : int = _cards.size()
	
	return _cards_count

func calculated_new_cards_count(_deck : Dictionary) -> int:
	var _new_cards_studied_query : String = "SELECT new_cards_studied FROM Deck_History WHERE Deck_History.date = " + str(today_date) + " AND Deck_History.deck_id = " + str(_deck["deck_id"])
	var _new_cards_studied_result : int = 0
	
	if USERDATA.get_by_query(_new_cards_studied_query):
		_new_cards_studied_result = USERDATA.get_by_query(_new_cards_studied_query)[0]["new_cards_studied"]
	
	var _cards : Array = _deck["cards"]
	var _new_cards_limit : int = _deck["settings"]["new_cards_per_day"] - _new_cards_studied_result
	var _new_cards_count : int = 0
	
	for _c in _cards:
		if _new_cards_count >= _new_cards_limit:
			break
		else:
			if not _c["last_session"]:
				_new_cards_count += 1
	
	return _new_cards_count

func calculated_due_cards_count(_deck : Dictionary) -> int:
	var _cards : Array = _deck["cards"]
	var _due_cards_count : int = 0
	
	for _c in _cards:
		if _c["last_session"]:
			var _next_session : int = _c["last_session"] + _c["space_btwn_sessions"] * UNIX_DAY
			if today_date >= _next_session:
				_due_cards_count += 1
	
	return _due_cards_count
