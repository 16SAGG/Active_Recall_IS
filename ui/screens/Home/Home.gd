extends Control

const DECK_BOX = preload("res://ui/components/DeckBox/DeckBox.tscn")
const PENDING_DECK = preload("res://ui/screens/Home/components/PendingDeck/PendingDeck.tscn")

# warning-ignore:unused_signal
signal go_to_deck_screen_requested(deck)
# warning-ignore:unused_signal
signal go_to_practice_screen_requested(deck)

onready var _deck_columns = $MarginContainer/ScrollContainer/Content/Columns as HBoxContainer
onready var _pending_column = $FloatingColumn/PendingDecks/Layout/MarginContainer/ScrollContainer/Content as VBoxContainer

var _deck_array = []
var _next_column_id : int = 0

func _ready() -> void:
	_load_data()

func _load_data() -> void:
	for _d in USERDATA.starting_data:
		var _new_cards : int = CARDCULATIONS.calculated_new_cards_count(_d)
		var _due_cards : int = CARDCULATIONS.calculated_due_cards_count(_d)
		_insert_deck_box(_d.title, _new_cards, _due_cards)
		
		var _pending_cards : int = _new_cards + _due_cards
		if _pending_cards > 0:
			_insert_pending_deck(_d.title, _pending_cards)

func _insert_deck_box(_title: String, _new_cards: int, _due_cards: int) -> void:
	var _deck_box: Control = DECK_BOX.instance()
	var _deck_column: VBoxContainer = _deck_columns.get_node("Column_" + str(_next_column_id))
	
	_deck_box.title = _title
	_deck_box.new_cards_count = _new_cards
	_deck_box.due_cards_count = _due_cards
	
	_deck_column.add_child(_deck_box)
	
# warning-ignore:return_value_discarded
	_deck_box.connect("box_flip", self, "_on_switch_box_to_front")
# warning-ignore:return_value_discarded
	_deck_box.connect("deck_pressed", self, "_on_deck_pressed")
	
	_deck_array.append(_deck_box)
	
	if _next_column_id == 0:
		_next_column_id = 1
	else:
		_next_column_id = 0

func _insert_pending_deck(_title : String, _pending_cards : int) -> void:
	var _pending_deck : Control = PENDING_DECK.instance()
	
	_pending_deck.title = _title
	_pending_deck.pending_cards_count = _pending_cards
	
	_pending_column.add_child(_pending_deck)
	
# warning-ignore:return_value_discarded
	_pending_deck.connect("box_flip", self, "_on_switch_box_to_front")
# warning-ignore:return_value_discarded
	_pending_deck.connect("deck_pressed", self, "_on_deck_pressed")
	
	_deck_array.append(_pending_deck)

func _on_switch_box_to_front(_deck: Control) -> void:
	for db in _deck_array:
		if db == _deck:
			pass
		else:
			if db.side == "BACK":
				db.back_action()

func _on_deck_pressed(_deck: Control, _screen: String) -> void:
	emit_signal("go_to_" + _screen + "_screen_requested", _deck)

