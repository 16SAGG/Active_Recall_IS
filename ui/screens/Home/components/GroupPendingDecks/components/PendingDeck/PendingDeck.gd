extends "res://ui/components/ButtonBase/ButtonBase.gd"

# warning-ignore:unused_signal
signal deck_pressed(button, screen)

onready var _front_title_label : Label = $Pivot/Front/MarginContainer/Layout/Title
onready var _front_pending_cards = $Pivot/Front/MarginContainer/Layout/PendingCards as Label

onready var _back_title_label : Label = $Pivot/Back/MarginContainer/Layout/Title
onready var _back_pending_cards = $Pivot/Back/MarginContainer/Layout/PendingCards as Label

var id : int
var title : String
var pending_cards_count : int

var _screen = "practice"

func _ready():
	_set_values(title, pending_cards_count)

func _set_values(_title : String, _pending_cards_count : int) -> void:
	_front_title_label.text = _title
	_front_pending_cards.text = str(_pending_cards_count)
	
	_back_title_label.text = _title
	_back_pending_cards.text = str(_pending_cards_count)

func _on_BackTrigger_pressed():
	emit_signal("deck_pressed", self, _screen)
