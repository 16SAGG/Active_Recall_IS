extends Control

signal click_outside
signal daily_study_requested(card_count)
signal custom_study_requested(card_count)

onready var _mouse_detector = $MouseDetector as Control

onready var _left_button = $Layout/LeftButton as Control
onready var _type_of_study = $Layout/TypeOfStudy as Control
onready var _right_button = $Layout/RightButton as Control

var showed : bool = false setget _setget_showed

var _current_type : int = 0

func _ready() -> void:
	_mouse_detector.connect("click_outside", self, "_on_click_outside")
	
	_left_button.connect("clicked", self, "_on_left_button_pressed")
	_right_button.connect("clicked", self, "_on_right_button_pressed")
	
	_type_of_study.connect("daily_study_requested", self, "_on_daily_study_requested")
	_type_of_study.connect("custom_study_requested", self, "_on_custom_study_requested")
	
	_right_button.set_icon("RIGHT")
	_left_button.set_icon("LEFT")

func start(var _s_option : Dictionary) -> void:
	_current_type = 0
	_type_of_study.start(_s_option)
	
	_change_option()

func _setget_showed(var _showed : bool) -> void:
	_mouse_detector.active = _showed

func _on_click_outside():
	emit_signal("click_outside")

func _change_option() -> void:
	if _type_of_study.types_count:
		_type_of_study.set_values(_current_type)

func _on_left_button_pressed() -> void:
	if _current_type <= 0:
		_current_type = _type_of_study.types_count - 1
	else:
		_current_type -= 1
	
	_change_option()
	
func _on_right_button_pressed() -> void:
	if _current_type >= _type_of_study.types_count - 1:
		_current_type = 0
	else:
		_current_type += 1
	
	_change_option()

func _on_daily_study_requested(var _card_count : int) -> void:
	emit_signal("daily_study_requested", _card_count)

func _on_custom_study_requested(var _card_count : int) -> void:
	emit_signal("custom_study_requested", _card_count)
