extends Control

const H4_HEADLINE = preload("res://miscellaneous/fonts/dynamic_fonts/H4_headline.tres")
const H5_HEADLINE = preload("res://miscellaneous/fonts/dynamic_fonts/H5_headline.tres")

signal ready_for_base

onready var _show_answer_player = $ShowAnswerPlayer as AnimationPlayer
onready var move_player = $MovePlayer as AnimationPlayer

onready var _question_header = $Pivot/MarginContainer/Layout/QuestionLayout/Question as Label
onready var _description = $Pivot/MarginContainer/Layout/QuestionLayout/Description as TextEdit
onready var _continue = $Pivot/MarginContainer/Layout/Continue as Button
onready var _base = $Base as MarginContainer

var _has_description : bool = false

func _ready():
	pass

func start(var _question : Dictionary, _answer : Dictionary) -> void:
	_set_values(_question, _answer)
	_base.start()

func _set_values(var _question : Dictionary, _answer : Dictionary)  -> void:
	_text_supervisor(_question["title"])
	_continue.visible = false
	_description.visible = false
	_has_description = false
	
	_show_answer_player.play("RESET")
	_question_header.change_text(_question["title"])
	if _answer["description"]:
		_description.text = _answer["description"]
		_has_description = true

func show_answer(var _result : String) -> void:
	_continue.visible = true
	if _has_description:
		_description.visible = true
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
