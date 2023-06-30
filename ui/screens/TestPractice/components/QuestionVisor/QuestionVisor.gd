extends Control

const H4_HEADLINE = preload("res://miscellaneous/fonts/dynamic_fonts/H4_headline.tres")
const H5_HEADLINE = preload("res://miscellaneous/fonts/dynamic_fonts/H5_headline.tres")

signal ready_for_base

onready var _show_answer_player = $ShowAnswerPlayer as AnimationPlayer
onready var move_player = $MovePlayer as AnimationPlayer

onready var _question_header = $Pivot/MarginContainer/Layout/QuestionLayout/Question as Label
onready var _extra_content = $Pivot/MarginContainer/Layout/QuestionLayout/ExtraContent as VBoxContainer
onready var _image = $Pivot/MarginContainer/Layout/QuestionLayout/ExtraContent/Image as Control
onready var _description = $Pivot/MarginContainer/Layout/QuestionLayout/ExtraContent/Description as TextEdit
onready var _continue = $Pivot/MarginContainer/Layout/Continue as Button
onready var _base = $Base as MarginContainer

var _answer_description : String = ""
var _answer_img : String = ""

func _ready():
	pass

func start(var _question : Dictionary, _answer : Dictionary) -> void:
	_set_values(_question, _answer)
	_base.start()

func _set_values(var _question : Dictionary, _answer : Dictionary)  -> void:
	_text_supervisor(_question["title"])
	_continue.visible = false
	_extra_content.visible = false
	_image.visible = false
	_description.visible = false
	_answer_description = ""
	_answer_img = ""
	
	_show_answer_player.play("RESET")
	_question_header.change_text(_question["title"])
	
	if _question["img_dir"]:
		_image.visible = true
		_image.change_image(_question["img_dir"])
		_extra_content.visible = true
	if _answer["description"]:
		_answer_description = _answer["description"]
	if _answer["img_dir"]:
		_answer_img = _answer["img_dir"]

func show_answer(var _result : String) -> void:
	_continue.visible = true
	if _answer_description or _answer_img:
		_extra_content.visible = true
		if _answer_description != "":
			_description.visible = true
			_description.text = _answer_description
		
		if _answer_img != "":
			_image.visible = true
			_image.change_image(_answer_img)
		else:
			_image.visible = false
	else:
		_extra_content.visible = false
	
	if _result == "WRONG":
		_show_answer_player.play("WRONG_ANSWER")

func _text_supervisor(var _text : String) -> void:
	if _text.length() < 12:
		_question_header.add_font_override("font", H4_HEADLINE)
	else:
		_question_header.add_font_override("font", H5_HEADLINE)

func show_base(var _title : String, var _next_day : int) -> void:
	_base.set_values(_title, _next_day)
	move_player.play("GO_UP")

func _on_MovePlayer_animation_finished(anim_name):
	if anim_name == "GO_UP":
		_base.anim_player.play("SHOW")

func _on_Continue_button_up():
	emit_signal("ready_for_base")
