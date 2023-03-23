extends "res://ui/components/DeckBox/DeckBox.gd"

onready var _title_label : Label = $Pivot/Front/MarginContainer/Layout/Title
onready var _pending_cards = $Pivot/Front/MarginContainer/Layout/PendingCards as Label

var title : String
var pending_cards_count : int

func _ready():
	_set_values(title, pending_cards_count)

func _set_values(_title : String, _pending_cards_count : int) -> void:
	_title_label.text = _title
	_pending_cards.text = str(_pending_cards_count)
