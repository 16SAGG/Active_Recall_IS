extends Node

const UNIX_DAY = 86400

func calculated_new_cards_count(_deck : Dictionary) -> int:
	var _cards : Array = _deck["cards"]
	var _new_cards_limit : int = _deck["new_cards_per_day"]
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
	var _today_date : int = OS.get_unix_time()
	var _due_cards_count : int = 0
	
	for _c in _cards:
		if _c["last_session"]:
			var _next_session : int = _c["last_session"] + _c["space_btwn_sessions"]
			if _today_date >= _next_session:
				_due_cards_count += 1
	
	return _due_cards_count
