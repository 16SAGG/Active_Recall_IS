extends Node

const SQLITE = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

var user_id : int = 1

var decks_data : Array
var current_deck_data : Dictionary

var images_data : Array

var history_data : Array

var current_theme = "DEFAULT"

var _database
var _db_name = "res://data/database"

func _ready() -> void:
	_database = SQLITE.new()
	_database.path = _db_name
	
	set_basic_data()

func set_basic_data() -> void: 
	turn_('ON')
	
	_set_history_data()
	_set_decks_data()
	_set_img_data()
	
	turn_('OFF')

func commit_data(table : String, data : Dictionary) -> void:
	turn_('ON')
	
	_database.insert_row(table, data)
	
	turn_('OFF')

func _set_decks_data() -> void:
	var _d_q : String = "SELECT Deck.deck_id, Deck.title, Deck.new_cards_per_day, Deck.state FROM Deck LEFT JOIN User ON Deck.user_id = User.user_id WHERE User.user_id = " + str(user_id)
	var _data : Array = get_by_query(_d_q)
	
	for _d in _data:
		var _dc_q : String = "SELECT Card.card_id, Card.last_session, Card.space_btwn_sessions FROM Card LEFT JOIN Deck ON Card.deck_id = Deck.deck_id WHERE Card.deck_id = " + str(_d["deck_id"])
		_d['cards'] = get_by_query(_dc_q)
	
	decks_data = _data

func set_current_deck_data(_deck_id : int) -> void:
	turn_('ON')
	
	var _d_q : String = "SELECT Deck.deck_id, Deck.title, Deck.days_studied, Deck.days_on_streak, Deck.days_on_streak_record, Deck.new_cards_per_day, Deck.state FROM Deck LEFT JOIN User ON Deck.user_id = User.user_id WHERE User.user_id = " + str(user_id) + " AND Deck.deck_id = " + str(_deck_id)
	var _data : Dictionary = get_by_query(_d_q)[0]
	
	var _dc_q : String = "SELECT Card.card_id, Card.question_id, Card.answer_id, Card.hits, Card.fails, Card.last_session, Card.space_btwn_sessions FROM Card LEFT JOIN Deck ON Card.deck_id = Deck.deck_id WHERE Card.deck_id = " + str(_deck_id)
	_data['cards'] = get_by_query(_dc_q)
	
	for _c in range(0, _data['cards'].size()):
		var _answer_id = _data['cards'][_c]['answer_id']
		var _question_id = _data['cards'][_c]['question_id']
		
		var _da_q : String = "SELECT Answer.title, Answer.image, Answer.description FROM Answer LEFT JOIN Card ON Answer.answer_id = Card.answer_id WHERE Answer.answer_id = " + str(_answer_id)
		_data['cards'][_c]['answer'] = get_by_query(_da_q)[0]
		
		var _dq_q : String = "SELECT Question.title, Question.image FROM Question LEFT JOIN Card ON Question.question_id = Card.question_id WHERE Question.question_id = " + str(_question_id)
		_data['cards'][_c]['question'] = get_by_query(_dq_q)[0]
	
	turn_('OFF')
	
	current_deck_data = _data
	
	#current_deck_data = {
	#	'cards': [
	#		{
	#			'answer': {
	#				'image': {}
	#			}
	#			'question': {
	#				'image': {}
	#			}
	#		}
	#	]
	#}

func _set_history_data() -> void:
	var _d_q : String = "SELECT History.date, History.activity FROM History LEFT JOIN User ON History.user_id = User.user_id WHERE User.user_id = " + str(user_id)
	var _data : Array = get_by_query(_d_q)
	
	history_data = _data

func _set_img_data() -> void:
	var _d_q : String = "SELECT Image.image_id, Image.width, Image.height, Image.format, Image.data FROM Image"
	var _data : Array = get_by_query(_d_q)
	
	images_data = _data

func get_by_query(_query) -> Array:
	_database.query(_query)
	
	return _database.query_result

func turn_(_state : String) -> void:
	match _state:
		'ON':
			_database.open_db()
		'OFF':
			_database.close_db()
