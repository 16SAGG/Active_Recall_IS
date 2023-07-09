extends "res://ui/components/ButtonBase/ButtonBase.gd"

const H5_HEADLINE = preload("res://miscellaneous/fonts/dynamic_fonts/H5_headline.tres")
const H6B_HEADLINE = preload("res://miscellaneous/fonts/dynamic_fonts/H6B_headline.tres")
const H7_HEADLINE = preload("res://miscellaneous/fonts/dynamic_fonts/H7_headline.tres")

onready var _front_actual_card = $Pivot/Front/MarginContainer/Content/ActualCard as Label
onready var _front_title = $Pivot/Front/MarginContainer/Content/Title as Label
onready var _front_extra = $Pivot/Front/MarginContainer/Content/ExtraContent as HBoxContainer
onready var _front_image = $Pivot/Front/MarginContainer/Content/ExtraContent/Image as Control
onready var _front_flip_button = $Pivot/Front/MarginContainer/Content/FlipButton/Button as Control

onready var _back_actual_card = $Pivot/Back/MarginContainer/Content/ActualCard as Label
onready var _back_title = $Pivot/Back/MarginContainer/Content/Title as Label
onready var _back_extra = $Pivot/Back/MarginContainer/Content/ExtraContent as HBoxContainer
onready var _back_image = $Pivot/Back/MarginContainer/Content/ExtraContent/Image as Control
onready var _back_desc = $Pivot/Back/MarginContainer/Content/ExtraContent/Description as TextEdit
onready var _back_flip_button = $Pivot/Back/MarginContainer/Content/FlipButton/Button as Control

func _ready() -> void:
	_front_flip_button.connect("pressed", self, "_on_front_flip_button_pressed")
	_back_flip_button.connect("pressed", self, "_on_back_flip_button_pressed")

func set_values(var _front : Dictionary, var _back : Dictionary, var _current_card_index : int, var _card_count : int) -> void:
	_front_actual_card.visible = false
	_front_flip_button.get_parent().visible = false
	
	_front_title.visible = false
	_front_extra.visible = false
	_front_image.visible = false
	
	_back_title.visible = false
	_back_extra.visible = false
	_back_desc.visible = false
	_back_image.visible = false
	
	_front_actual_card.text = str(_current_card_index + 1) + "/" + str(_card_count)
	if _front:
		_front_actual_card.visible = true
		_front_flip_button.get_parent().visible = true
		if _front["title"]:
			_front_title.visible = true
			_front_title.text = _front["title"]
		if _front["img_dir"]:
			_front_extra.visible = true
			_front_image.visible = true
			_front_image.change_image(_front["img_dir"])
		_text_supervisor(_front["title"], "FRONT")
	
	_back_actual_card.text = str(_current_card_index + 1) + "/" + str(_card_count)
	if _back:
		if _back["title"]:
			_back_title.visible = true
			_back_title.text = _back["title"]
		if _back["description"]:
			_back_extra.visible = true
			_back_desc.visible = true
			_back_desc.text = _back["description"]
		if _back["img_dir"]:
			_back_extra.visible = true
			_back_image.visible = true
			_back_image.change_image(_back["img_dir"])
		_text_supervisor(_back["title"], "BACK")

func _text_supervisor(var _text : String, var _side : String) -> void:
	match _side:
		"FRONT":
			if _text.length() < 12:
				_front_title.add_font_override("font", H5_HEADLINE)
			else:
				_front_title.add_font_override("font", H6B_HEADLINE)
		"BACK":
			if _text.length() < 12:
				_back_title.add_font_override("font", H5_HEADLINE)
			else:
				_back_title.add_font_override("font", H6B_HEADLINE)

func _on_front_flip_button_pressed() -> void:
	front_action()

func _on_back_flip_button_pressed() -> void:
	back_action()
