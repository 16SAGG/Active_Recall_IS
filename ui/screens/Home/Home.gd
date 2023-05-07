extends "res://ui/screens/ScreenBase.gd"

const DECK_BOX = preload("res://ui/components/DeckBox/DeckBox.tscn")
const PENDING_DECK = preload("res://ui/screens/Home/components/GroupPendingDecks/components/PendingDeck/PendingDeck.tscn")

# warning-ignore:unused_signal
signal go_to_deck_screen_requested(deck)
# warning-ignore:unused_signal
signal go_to_practice_screen_requested(deck)

onready var _deck_columns = $MarginContainer/ScrollContainer/Content/Columns as HBoxContainer
onready var _search_bar = $FloatingColumn/SearchBar as Control
onready var _group_PD = $FloatingColumn/GroupPendingDecks as Control
onready var _pending_column = _group_PD.content as VBoxContainer

var _deck_array : Array = []
var _next_column_id : int = 0

func _ready() -> void:
	_search_bar.connect("search", self, "_on_search")
	
	start()

func start() -> void:
	_group_PD.start()
	_deck_array = _load_data()
	_remove_all_decks()
	_insert_deck_array("")

func _load_data() -> Array:
	var _result_array : Array
	for _d in USERDATA.decks_data:
		var _new_cards : int = CARDCULATIONS.calculated_new_cards_count(_d)
		var _due_cards : int = CARDCULATIONS.calculated_due_cards_count(_d)
		_result_array.append(_create_deck_box(_d.deck_id, _d.title, _new_cards, _due_cards))
		
		var _pending_cards : int = _new_cards + _due_cards
		if _pending_cards > 0:
			_result_array.append(_create_pending_deck(_d.deck_id, _d.title, _pending_cards))
	
	return _result_array

func _create_deck_box(_id : int, _title: String, _new_cards: int, _due_cards: int) -> Control:
	var _deck_box: Control = DECK_BOX.instance()
	
	_deck_box.id = _id
	_deck_box.title = _title
	_deck_box.new_cards_count = _new_cards
	_deck_box.due_cards_count = _due_cards
	
# warning-ignore:return_value_discarded
	_deck_box.connect("back_flip", self, "_on_switch_box_to_front")
# warning-ignore:return_value_discarded
	_deck_box.connect("deck_pressed", self, "_on_deck_pressed")
	
	return _deck_box

func _create_pending_deck(_id : int, _title : String, _pending_cards : int) -> Control:
	var _pending_deck : Control = PENDING_DECK.instance()
	
	_pending_deck.id = _id
	_pending_deck.title = _title
	_pending_deck.pending_cards_count = _pending_cards
	
# warning-ignore:return_value_discarded
	_pending_deck.connect("back_flip", self, "_on_switch_box_to_front")
# warning-ignore:return_value_discarded
	_pending_deck.connect("deck_pressed", self, "_on_deck_pressed")
	
	return _pending_deck

func _set_deck_box_next_column() -> void:
	if _next_column_id == 0:
		_next_column_id = 1
	else:
		_next_column_id = 0

func _insert_one_deck(_deck : Control) -> void:
	match _deck.is_in_group("PENDING"):
		true:
			_pending_column.add_child(_deck)
		false:
			var _next_column : VBoxContainer = get_node("MarginContainer/ScrollContainer/Content/Columns/Column_" + str(_next_column_id))
			_next_column.add_child(_deck)
			_set_deck_box_next_column()

func _insert_deck_array(_search : String) -> void:
	for _d in _deck_array:
		if _search.to_upper() in _d.title.to_upper() or _search == "":
			_insert_one_deck(_d)

func _remove_all_decks() -> void:
	for _column in _deck_columns.get_children():
		for _c in _column.get_children():
			_column.remove_child(_c)
	
	for _p in _pending_column.get_children():
		if _p.is_in_group("PENDING"):
			_pending_column.remove_child(_p)
	
	_next_column_id = 0

func _on_search(text : String) -> void:
	_remove_all_decks()
	_insert_deck_array(text)

func _on_switch_box_to_front(_deck: Control) -> void:
	for _db in _deck_array:
		if _db == _deck:
			pass
		else:
			if _db.side == "BACK":
				_db.back_action()

func _on_deck_pressed(_deck: Control, _screen: String) -> void:
	emit_signal("go_to_" + _screen + "_screen_requested", _deck)


