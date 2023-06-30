extends Node

const SQLITE = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

var current_user: int = 1

var users_data : Array
var user_history : Array
var decks_data : Array
var current_user_data : Dictionary
var current_deck_data : Dictionary

var current_theme = "DEFAULT"

var _database
var _db_name = "res://data/database"

func _ready() -> void:
	_database = SQLITE.new()
	_database.path = _db_name
	
	turn_('ON')

func set_users_data() -> void:
	var _u_q : String = "SELECT user_id, email, password FROM User"
	var _data : Array = get_by_query(_u_q)
	
	users_data = _data

func set_user_history() -> void:
	var _h_q : String = "SELECT date FROM Deck_History WHERE user_id = " + str(current_user) + " AND date <= " + str(CARDCULATIONS.today_date) +  " ORDER BY date DESC"
	var _history = get_by_query(_h_q)
	
	user_history = _history

func set_current_user_data() -> void:
	var _u_q : String = "SELECT user_id, name, last_name, email, password, current_theme FROM User WHERE user_id = " + str(current_user)
	var _data : Dictionary = get_by_query(_u_q)[0]
	
	current_user_data = _data

func set_basic_data() -> void: 
	_set_decks_data()

func commit_data(_table : String, _data : Dictionary) -> void:
	_database.insert_row(_table, _data)

func update_data(_table : String, _condition : String, _data : Dictionary) -> void:
	_database.update_rows(_table, _condition, _data)

func delete_data(_table : String, _condition : String) -> void:
	_database.delete_rows(_table, _condition)

func _set_decks_data() -> void:
	var _d_q : String = "SELECT Deck.deck_id, Deck.title, Deck.days_on_streak FROM Deck LEFT JOIN User ON Deck.user_id = User.user_id WHERE User.user_id = " + str(current_user)
	var _data : Array = get_by_query(_d_q)
	
	for _d in _data:
		var _dc_q : String = "SELECT Card.card_id, Card.last_session, Card.space_btwn_sessions FROM Card LEFT JOIN Deck ON Card.deck_id = Deck.deck_id WHERE Card.deck_id = " + str(_d["deck_id"])
		_d['cards'] = get_by_query(_dc_q)
	
	for _d in _data:
		var _ds_q : String = "SELECT Deck_Set.new_cards_per_day, Deck_Set.state FROM Deck_Settings AS Deck_Set WHERE Deck_Set.deck_id = " + str(_d["deck_id"])
		_d['settings'] = get_by_query(_ds_q)[0]
	
	decks_data = _data

func set_current_deck_data(_deck_id : int) -> void:
	var _d_q : String = "SELECT Deck.deck_id, Deck.user_id, Deck.title, Deck.days_on_streak_record FROM Deck LEFT JOIN User ON Deck.user_id = User.user_id WHERE User.user_id = " + str(current_user) + " AND Deck.deck_id = " + str(_deck_id)
	var _data : Dictionary = get_by_query(_d_q)[0]
	
	var _ddos_q : String = "SELECT date FROM Deck_History WHERE deck_id = " + str(_deck_id) + " AND date <= " + str(CARDCULATIONS.today_date) + " ORDER BY date"
	var _history : Array = get_by_query(_ddos_q)
	
	var _days_on_streak_count : int = 1
	if _history.size() > 0:
		var _h_size : int = _history.size() - 1
		var _last_history_date : int = _history[_h_size]["date"]
	
		for _h in range(1, _history.size()):
			var _current_history_date : int = _history[_h_size - _h]["date"]
			
			if _last_history_date - CARDCULATIONS.UNIX_DAY == _current_history_date:
				_days_on_streak_count += 1
			else:
				break
			
			_last_history_date = _current_history_date
	
	_data['days_on_streak'] = _days_on_streak_count
	if _data['days_on_streak'] > _data['days_on_streak_record']:
		_data['days_on_streak_record'] = _data['days_on_streak']
		update_data('Deck', "deck_id = " + str(_deck_id), _data)
	
	var _dc_q : String = "SELECT Card.card_id, Card.deck_id, Card.question_id, Card.answer_id, Card.hits, Card.fails, Card.last_session, Card.space_btwn_sessions FROM Card LEFT JOIN Deck ON Card.deck_id = Deck.deck_id WHERE Card.deck_id = " + str(_deck_id)
	_data['cards'] = get_by_query(_dc_q)
	
	var _ds_q : String = "SELECT Deck_Set.settings_id, Deck_Set.deck_id, Deck_Set.new_cards_per_day, Deck_Set.state FROM Deck_Settings AS Deck_Set WHERE Deck_Set.deck_id = " + str(_data["deck_id"])
	_data['settings'] = get_by_query(_ds_q)[0]
	
	for _c in range(0, _data['cards'].size()):
		var _answer_id = _data['cards'][_c]['answer_id']
		var _question_id = _data['cards'][_c]['question_id']
		
		var _da_q : String = "SELECT Answer.answer_id, Answer.title, Answer.description, Answer.img_dir FROM Answer LEFT JOIN Card ON Answer.answer_id = Card.answer_id WHERE Answer.answer_id = " + str(_answer_id)
		_data['cards'][_c]['answer'] = get_by_query(_da_q)[0]
		
		var _dq_q : String = "SELECT Question.question_id, Question.title, Question.img_dir FROM Question LEFT JOIN Card ON Question.question_id = Card.question_id WHERE Question.question_id = " + str(_question_id)
		_data['cards'][_c]['question'] = get_by_query(_dq_q)[0]
	
	current_deck_data = _data
	
	#current_deck_data = {
	#	'cards': [
	#		{
	#			'answer': {
	#			}
	#			'question': {
	#			}
	#		}
	#	]
	#}

func get_by_query(_query) -> Array:
	_database.query(_query)
	
	return _database.query_result

func turn_(_state : String) -> void:
	match _state:
		'ON':
			_database.open_db()
		'OFF':
			_database.close_db()
