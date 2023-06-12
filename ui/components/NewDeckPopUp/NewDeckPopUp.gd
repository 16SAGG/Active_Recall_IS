extends Control

signal new_deck(title)
signal hide_new_deck_pop_up_requested

export var showed : bool = false setget _setget_showed

onready var animation_player = $AnimationPlayer as AnimationPlayer

onready var _mouse_detector = $MouseDetector as Control
onready var _ok_button = $Pivot/MarginContainer/Layout/Content/OkButton as Control
onready var _new_title = $Pivot/MarginContainer/Layout/Content/NewTitle as LineEdit
onready var _error_label = $Pivot/MarginContainer/Layout/Header/Error as Label

func _ready() -> void:
	_ok_button.connect("normal_flip", self, "_on_ok_button_pressed")
	_mouse_detector.connect("click_outside", self, "_on_click_outside")
	
	_error_label.visible = true
	_error_label.text = "Vacío"
	_ok_button._disable_button(true)

func start() -> void:
	_new_title.text = ""

func _setget_showed(var _showed : bool) -> void:
	showed = _showed
	if _mouse_detector:
		_mouse_detector.active = _showed

func _on_ok_button_pressed(_button : Control) -> void:
	emit_signal("new_deck", _new_title.text)

func _on_click_outside() -> void:
	emit_signal("hide_new_deck_pop_up_requested")

# warning-ignore:unused_argument
func _on_NewTitle_text_changed(new_text):
	_error_label.visible = false
	_ok_button._disable_button(false)
	if TEXTFORMAT.remove_unnecessary_space(_new_title.text) == "":
		_error_label.visible = true
		_error_label.text = "Vacío"
		_ok_button._disable_button(true)
	else:
		for _d in USERDATA.decks_data:
			if TEXTFORMAT.remove_unnecessary_space(_new_title.text).to_upper() == _d["title"].to_upper():
				_error_label.visible = true
				_error_label.text = "Duplicado"
				_ok_button._disable_button(true)
				break
	
