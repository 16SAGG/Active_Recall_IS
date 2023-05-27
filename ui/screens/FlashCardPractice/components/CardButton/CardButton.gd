extends "res://ui/components/ButtonBase/ButtonBase.gd"

const H2_HEADLINE = preload("res://miscellaneous/fonts/dynamic_fonts/H2_headline.tres")
const H4_HEADLINE = preload("res://miscellaneous/fonts/dynamic_fonts/H4_headline.tres")

signal first_flip

onready var _front_control = $Pivot/Front as Control
onready var _front_title = $Pivot/Front/MarginContainer/Layout/Content/Title as Label
onready var _front_image = $Pivot/Front/MarginContainer/Layout/Content/Image as Control
onready var _front_flip_button = $Pivot/Front/MarginContainer/Layout/FlipButton as Button

onready var _back_control = $Pivot/Back as Control
onready var _back_title = $Pivot/Back/MarginContainer/Layout/Title as Label
onready var _back_extra = $Pivot/Back/MarginContainer/Layout/ExtraContent as HBoxContainer
onready var _back_desc = $Pivot/Back/MarginContainer/Layout/ExtraContent/Description as TextEdit
onready var _back_image = $Pivot/Back/MarginContainer/Layout/ExtraContent/Image as Control
onready var _back_flip_button = $Pivot/Back/MarginContainer/Layout/FlipButton as Button

onready var _cover_title = $Pivot/Back/Cover/Layout/Content/Title as Label
onready var _cover_image = $Pivot/Back/Cover/Layout/Content/Image as Control
onready var _cover_flip_button = $Pivot/Back/Cover/Layout/FlipButton as Button

onready var _show_answer_player = $ShowAnswerPlayer as AnimationPlayer

var _first_flip : bool = true

func _ready() -> void:
	_front_flip_button.connect("pressed", self, "_on_front_flip_button_pressed")
	_back_flip_button.connect("pressed", self, "_on_back_flip_button_pressed")
	_cover_flip_button.connect("pressed", self, "_on_back_flip_button_pressed")

func start(var _front : Dictionary, var _back : Dictionary, var _cover : Dictionary) -> void:
	_front_control.visible = true
	_back_control.visible = false
	_show_answer_player.play("RESET")
	_first_flip = true
	
	_set_values(_front, _back, _cover)

func _set_values(var _front : Dictionary, var _back : Dictionary, var _cover : Dictionary) -> void:
	_front_title.visible = false
	_front_image.visible = false
	
	_back_title.visible = false
	_back_extra.visible = false
	_back_desc.visible = false
	_back_image.visible = false
	
	_cover_title.visible = false
	_cover_image.visible = false
	
	if _front:
		if _front["title"]:
			_front_title.visible = true
			_front_title.text = _front["title"]
		#if _front["image"]:
		#	_front_image.visible = true
		
		_text_supervisor(_front["title"], "FRONT")
	
	if _back:
		if _back["title"]:
			_back_title.visible = true
			_back_title.text = _back["title"]
			_cover_title.text = _back["title"]
		if _back["description"]:
			_back_extra.visible = true
			_back_desc.visible = true
			_back_desc.text = _back["description"]
		#if _back["image"]:
		#	_back_extra.visible = true
		#	_back_image.visible = true
		#	_cover_image.visible = true
		
		_text_supervisor(_back["title"], "BACK")
	
	if _cover:
		if _cover["title"]:
			_cover_title.visible = true
			_cover_title.text = _cover["title"]
		#if _cover["image"]:
		#	_cover_image.visible = true
		
		_text_supervisor(_cover["title"], "COVER")

func _text_supervisor(var _text : String, var _side : String) -> void:
	match _side:
		"FRONT":
			if _front_image.visible: 
				_front_title.add_font_override("font", H4_HEADLINE)
			else:
				if _text.length() < 12:
					_front_title.add_font_override("font", H2_HEADLINE)
				else:
					_front_title.add_font_override("font", H4_HEADLINE)
		"COVER":
			if _cover_image.visible: 
				_cover_title.add_font_override("font", H4_HEADLINE)
			else:
				if _text.length() < 12:
					_cover_title.add_font_override("font", H2_HEADLINE)
				else:
					_cover_title.add_font_override("font", H4_HEADLINE)
		"BACK":
			if _back_extra.visible:
				_back_title.add_font_override("font", H4_HEADLINE)
			else:
				if _text.length() < 12:
					_back_title.add_font_override("font", H2_HEADLINE)
				else:
					_back_title.add_font_override("font", H4_HEADLINE)

func show_answer(var _answer: String) -> void:
	if side == "FRONT":
		_back_control.visible = true
		_front_control.visible = false
		side = "BACK"
	match _answer:
		"CORRECT":
			_show_answer_player.play("CORRECT_ANSWER")
		"WRONG":
			_show_answer_player.play("WRONG_ANSWER")

func _on_front_flip_button_pressed() -> void:
	if _first_flip:
		_first_flip = false
		emit_signal("first_flip")
	front_action()

func _on_back_flip_button_pressed() -> void:
	back_action()


func _on_CardButton_resized():
	self.rect_size = self.rect_min_size
