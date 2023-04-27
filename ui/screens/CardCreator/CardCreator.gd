extends Control

signal change_deck_requested
signal new_card(question, answer, deck_id)

onready var _change_deck = $MarginContainer/Content/ChangeDeck as Control
onready var _add_image = $MarginContainer/Content/AddImage as Control
onready var _add_card = $MarginContainer/Content/Footer/Content/AddCard as Control

onready var _add_card_title = $MarginContainer/Content/Footer/Content/AddCard/Pivot/Front/MarginContainer/Title as Label

onready var _front_line = $MarginContainer/Content/LineBoxes/Content/FrontLine
onready var _front_line_edit = $MarginContainer/Content/LineBoxes/Content/FrontLine/MarginContainer/Content/FrontEdit

onready var _back_line = $MarginContainer/Content/LineBoxes/Content/BackLine
onready var _back_line_edit = $MarginContainer/Content/LineBoxes/Content/BackLine/MarginContainer/Content/BackEdit
onready var _back_line_desc = $MarginContainer/Content/LineBoxes/Content/BackLine/MarginContainer/Content/HBoxContainer/Description

var status : String = "CREATOR" #EDITOR
var editable_card : Control

var _current_focus : String = "NONE"

func _ready() -> void:
	_change_deck.connect("normal_flip", self, "_on_change_deck_pressed")
	_add_image.connect("normal_flip", self, "_on_add_image_pressed")
	_add_card.connect("normal_flip", self, "_on_add_card_pressed")
	
	_front_line_edit.connect("focus_entered", self, "_on_FrontEdit_focus_entered")
	_back_line_edit.connect("focus_entered", self, "_on_BackEdit_focus_entered")
	_back_line_desc.connect("focus_entered", self, "_on_BackEdit_focus_entered")
	
	start()

func start() -> void:
	_update_current_deck()
	
	match status:
		"CREATOR":
			_clean_lines()
			_set_button_title("Añadir")
		"EDITOR":
			_set_lines_to_edit()
			_set_button_title("Editar")

func _update_current_deck() -> void:
	if USERDATA.current_deck_data:
		_change_deck.set_title(USERDATA.current_deck_data["title"])

func _clean_lines() -> void:
	_front_line_edit.text = ""
	_back_line_edit.text = ""
	_back_line_desc.text = ""

func _set_lines_to_edit() -> void:
	_front_line_edit.text = editable_card.question_title
	_back_line_edit.text = editable_card.answer_title
	_back_line_desc.text = editable_card.answer_description

func _set_button_title(var title : String) -> void:
	_add_card_title.text = title

func _on_change_deck_pressed(_button : Control) -> void:
	emit_signal("change_deck_requested", _button)

func _on_add_image_pressed(_button : Control) -> void:
	match _current_focus:
		"FRONT":
			_front_line.show_image()
		"BACK":
			_back_line.show_image()

func _on_add_card_pressed(_button : Control) -> void:
	var _valid_card : bool = true
	
	var question : Dictionary = {
		"title" : _front_line_edit.text,
	}
	var answer : Dictionary = {
		"title" : _back_line_edit.text,
		"description" : _back_line_desc.text
	}
	
	if question["title"] == "" or answer["title"] == "" or !USERDATA.current_deck_data:
		_valid_card = false
	
	if _valid_card:
		match status:
			"CREATOR":
				emit_signal("new_card", question, answer, USERDATA.current_deck_data["deck_id"])
			"EDITOR":
				pass
	else:
		print("FICHA INVALIDA")

func _on_FrontEdit_focus_entered():
	_current_focus = "FRONT"

func _on_BackEdit_focus_entered():
	_current_focus = "BACK"
