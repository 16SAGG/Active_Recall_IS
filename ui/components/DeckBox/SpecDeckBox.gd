extends "res://ui/components/DeckBox/DeckBox.gd"

onready var _title_label : Label = $Pivot/Front/MarginContainer/Layout/Title
onready var _new_cards : Label = $Pivot/Front/MarginContainer/Layout/Cards/New
onready var _due_cards : Label = $Pivot/Front/MarginContainer/Layout/Cards/Due

var title : String
var new_cards_count : int
var due_cards_count : int

func _ready():
	_set_values(title, new_cards_count, due_cards_count)

func _set_values(_title : String, _new_cards_count : int, _due_cards_count : int) -> void:
	_title_label.text = _title
	_new_cards.text = "NEW: " + str(_new_cards_count)
	_due_cards.text = "DUE: " + str(_due_cards_count)
