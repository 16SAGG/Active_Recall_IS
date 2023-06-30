extends Control

onready var _left_button = $Layout/LeftButton as Control
onready var _card_button = $Layout/CardButton as Control
onready var _right_button = $Layout/RightButton as Control

var _card_array : Array = []
var _current_card_in_preview : int = 0

func _ready() -> void:
	_left_button.connect("clicked", self, "_on_left_button_pressed")
	_right_button.connect("clicked", self, "_on_right_button_pressed")
	
	_right_button.set_icon("RIGHT")
	_left_button.set_icon("LEFT")

func start() -> void:
	_card_array = _load_data()
	_current_card_in_preview = 0
	_change_card()

func _load_data() -> Array:
	var _result_array : Array
	
	if USERDATA.current_deck_data:
		for _c in USERDATA.current_deck_data["cards"]:
			var _dict : Dictionary = {
				"question": {
					"title": _c["question"]["title"],
					"img_dir": _c["question"]["img_dir"],
				},
				"answer": {
					"title": _c["answer"]["title"],
					"description": _c["answer"]["description"],
					"img_dir": _c["answer"]["img_dir"],
				}
			}
			_result_array.append(_dict)
	
	return _result_array

func _change_card() -> void:
	if _card_array:
		_card_button.set_values(_card_array[_current_card_in_preview]["question"], _card_array[_current_card_in_preview]["answer"], _current_card_in_preview, _card_array.size())
	else:
		_card_button.set_values(Dictionary(), Dictionary(), 0, 0)

func _on_left_button_pressed() -> void:
	if _current_card_in_preview <= 0:
		_current_card_in_preview = _card_array.size() - 1
	else:
		_current_card_in_preview -= 1
	
	_change_card()

func _on_right_button_pressed() -> void:
	if _current_card_in_preview >= _card_array.size() - 1:
		_current_card_in_preview = 0
	else:
		_current_card_in_preview += 1
	
	_change_card()
