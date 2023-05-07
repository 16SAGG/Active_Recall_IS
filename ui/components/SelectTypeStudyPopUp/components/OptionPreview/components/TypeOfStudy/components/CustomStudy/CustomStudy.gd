extends VBoxContainer

signal custom_study_requested(card_count)

onready var _card_count_label = $CardNumer/NumberInput/NumberContainer/Number as Label
onready var _increment_button = $CardNumer/NumberInput/Buttons/Increment as Control
onready var _decrement_button = $CardNumer/NumberInput/Buttons/Decrement as Control
onready var _enter_button = $ButtonLayout/EnterButton as Control

var _option_max_card_number : int
var _option_min_card_number : int

var _cards_in_deck : int
var _max_card_limit : int
var _min_card_limit : int
var _card_count : int = 15

func _ready() -> void:
	_increment_button.connect("clicked", self, "_on_increment_clicked")
	_decrement_button.connect("clicked", self, "_on_decrement_clicked")
	_enter_button.connect("normal_flip", self, "_on_enter_button_pressed")

func start(var _s_option : Dictionary) -> void:
	if USERDATA.current_deck_data:
		_option_max_card_number = _s_option["max_cards"]
		_option_min_card_number = _s_option["min_cards"]
		
		_cards_in_deck = CARDCULATIONS.calculated_all_cards_count(USERDATA.current_deck_data)
		
		if _cards_in_deck < _option_max_card_number:
			_max_card_limit = _cards_in_deck
			_card_count = _cards_in_deck
		else:
			_max_card_limit = _option_max_card_number
			_card_count = _max_card_limit
		
		_min_card_limit = _option_min_card_number
		
		_set_card_count(_card_count)

func _set_card_count(var _card_c : int) -> void:
	_card_count_label.text = str(_card_c)

func _on_increment_clicked() -> void:
	if _card_count < _max_card_limit:
		_card_count += 1
		_set_card_count(_card_count)

func _on_decrement_clicked() -> void:
	if _card_count > _min_card_limit:
		_card_count -= 1
		_set_card_count(_card_count)

func _on_enter_button_pressed(var _button : Control) -> void:
	emit_signal("custom_study_requested", _card_count)
