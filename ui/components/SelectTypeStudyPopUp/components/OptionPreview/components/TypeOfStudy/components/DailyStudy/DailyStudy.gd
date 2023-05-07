extends VBoxContainer

signal daily_study_requested(card_count)

onready var _enter_button = $ButtonLayout/EnterButton as Control
onready var _new_cards_count = $CardsToDo/NewCards/Count as Label
onready var _pending_cards_count = $CardsToDo/PendingCards/Count as Label

var _option_max_card_number : int
var _option_min_card_number : int
var _card_count : int

func _ready():
	_enter_button.connect("normal_flip", self, "_on_enter_button_pressed")

func start(var _s_option ) -> void:
	if USERDATA.current_deck_data:
		_option_max_card_number = _s_option["max_cards"]
		_option_min_card_number = _s_option["min_cards"]
		
		_new_cards_count.text = str(CARDCULATIONS.calculated_new_cards_count(USERDATA.current_deck_data))
		_pending_cards_count.text = str(CARDCULATIONS.calculated_due_cards_count(USERDATA.current_deck_data))
		
		var _card_for_today = int(_new_cards_count.text) + int(_pending_cards_count.text)
		
		if _card_for_today > _option_max_card_number:
			_card_count = _option_max_card_number
		elif _card_for_today < _option_min_card_number:
			_card_count = _option_min_card_number
		else: 
			_card_count = _card_for_today

func _on_enter_button_pressed(var _button : Control) -> void:
	print("You will see " + str(_card_count) + " cards in DailyStudy")
	print("Do the DailyStudy chain of signals, just like we did in CustomStudy")
	emit_signal("daily_study_requested", _card_count)
