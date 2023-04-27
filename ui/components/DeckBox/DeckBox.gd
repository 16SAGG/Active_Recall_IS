extends "res://ui/components/ButtonBase/ButtonBase.gd"

# warning-ignore:unused_signal
signal deck_pressed(button, screen)

onready var _front_title_label : Label = $Pivot/Front/MarginContainer/Layout/Title
onready var _front_new_cards : Label = $Pivot/Front/MarginContainer/Layout/Cards/New
onready var _front_due_cards : Label = $Pivot/Front/MarginContainer/Layout/Cards/Due

onready var _back_title_label : Label = $Pivot/Back/MarginContainer/Layout/Title
onready var _back_new_cards : Label = $Pivot/Back/MarginContainer/Layout/Cards/New
onready var _back_due_cards : Label = $Pivot/Back/MarginContainer/Layout/Cards/Due

var id : int
var title : String
var new_cards_count : int
var due_cards_count : int

var _screen = "deck"

func _ready():
	_set_values(title, new_cards_count, due_cards_count)

func _set_values(_title : String, _new_cards_count : int, _due_cards_count : int) -> void:
	_front_title_label.text = _title
	_front_new_cards.text = "NEW: " + str(_new_cards_count)
	_front_due_cards.text = "DUE: " + str(_due_cards_count)
	
	_back_title_label.text = _title
	_back_new_cards.text = "NEW: " + str(_new_cards_count)
	_back_due_cards.text = "DUE: " + str(_due_cards_count)

func _on_BackTrigger_pressed():
	emit_signal("deck_pressed", self, _screen)
