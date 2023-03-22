extends Control

const DECK_BOX = preload("res://ui/components/DeckBox/DeckBox.tscn")

# warning-ignore:unused_signal
signal go_to_deck_screen_requested(deck)
# warning-ignore:unused_signal
signal go_to_practice_screen_requested(deck)

onready var _columns = $MarginContainer/ScrollContainer/Content/Columns as HBoxContainer

var _deck_array = []
var _next_column_id : int = 0

func _ready() -> void:
	pass

func on_insert_deck_box(_title: String, _new_cards: int, _due_cards: int) -> void:
	var _deck_box: Control = DECK_BOX.instance()
	var _deck_column: VBoxContainer = _columns.get_node("Column_" + str(_next_column_id))
	
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

func _on_switch_box_to_front(deck: Control) -> void:
	for db in _deck_array:
		if db == deck:
			pass
		else:
			if db.side == "BACK":
				db.back_action()

func _on_deck_pressed(deck: Control, screen: String) -> void:
	emit_signal("go_to_" + screen + "_screen_requested", deck)

