extends Node

const SQLITE = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

var user_id : int = 1

var decks_data : Array

var history_data : Array

var current_theme = "DEFAULT"

var _database
var _db_name = "res://data/database"

func _ready() -> void:
	_database = SQLITE.new()
	_database.path = _db_name
	
	history_data = _get_history_data()
	decks_data = _get_decks_data()

func commit_data(table : String, data : Dictionary) -> void:
	_database.open_db()
	_database.insert_row(table, data)
	_database.close_db()
	
	decks_data = _get_decks_data()

func _get_decks_data() -> Array:
	var _d_q : String = "SELECT Deck.deck_id, Deck.title, Deck.new_cards_per_day, Deck.state FROM Deck LEFT JOIN User ON Deck.user_id = User.user_id WHERE User.user_id = " + str(user_id)
	var _data : Array = get_by_query(_d_q)
	
	for _d in _data:
		var _dc_q : String = "SELECT Card.card_id, Card.last_session, Card.space_btwn_sessions FROM Card LEFT JOIN Deck ON Card.deck_id = Deck.deck_id WHERE Card.deck_id = " + str(_d["deck_id"])
		_d['cards'] = get_by_query(_dc_q)
	
	return _data

func _get_history_data() -> Array:
	var _d_q : String = "SELECT History.date, History.activity FROM History LEFT JOIN User ON History.user_id = User.user_id WHERE User.user_id = " + str(user_id)
	var _data : Array = get_by_query(_d_q)
	
	return _data

func get_by_query(_query) -> Array:
	_database.open_db()
	_database.query(_query)
	_database.close_db()
	
	return _database.query_result
