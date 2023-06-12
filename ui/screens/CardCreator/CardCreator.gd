extends "res://ui/screens/ScreenBase.gd"

signal go_to_deck_screen_requested(deck)
signal new_card(question, answer, deck_id)
signal edit_card(new_question, new_answer, card, card_properties, update_deck)
signal update_history(count)
signal delete_card(question, answer, card)

onready var _change_deck = $MarginContainer/Content/ChangeDeck as Control
onready var _enter_button = $MarginContainer/Content/Footer/Content/Enter as Control
onready var _enter_button_title = $MarginContainer/Content/Footer/Content/Enter/Pivot/Front/MarginContainer/Title as Label
onready var _delete_button = $MarginContainer/Content/Footer/Content/Delete as Control

onready var _front_line = $MarginContainer/Content/LineBoxes/Content/FrontLine
onready var _front_line_edit = $MarginContainer/Content/LineBoxes/Content/FrontLine/MarginContainer/Content/FrontEdit

onready var _back_line = $MarginContainer/Content/LineBoxes/Content/BackLine
onready var _back_line_edit = $MarginContainer/Content/LineBoxes/Content/BackLine/MarginContainer/Content/BackEdit
onready var _back_line_desc = $MarginContainer/Content/LineBoxes/Content/BackLine/MarginContainer/Content/HBoxContainer/Description

var status : String = "CREATOR" #EDITOR
var editable_card : Dictionary

var _current_focus : String = "NONE"
var _front_line_permission : bool = false
var _back_line_permission : bool = false

func _ready() -> void:
	_change_deck.connect("normal_flip", self, "_on_change_deck_pressed")
	_enter_button.connect("normal_flip", self, "_on_enter_button_pressed")
	_delete_button.connect("normal_flip", self, "_on_delete_button_pressed")
	
	_front_line.connect("permission_to_enter", self, "_on_permission_to_enter")
	_front_line_edit.connect("focus_entered", self, "_on_FrontEdit_focus_entered")
	
	_back_line.connect("permission_to_enter", self, "_on_permission_to_enter")
	_back_line_edit.connect("focus_entered", self, "_on_BackEdit_focus_entered")
	_back_line_desc.connect("focus_entered", self, "_on_BackEdit_focus_entered")
	
	start()

func start() -> void:
	_front_line.start(status)
	_back_line.start(status)

	_update_current_deck()
	_error_suporter()
	
	match status:
		"CREATOR":
			_delete_button.visible = false
			_enter_button._disable_button(true)
			_clean_lines()
			_set_button_title("Añadir")
		"EDITOR":
			_delete_button.visible = true
			_enter_button._disable_button(false)
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
	_front_line_edit.text = editable_card["question"]["title"]
	_back_line_edit.text = editable_card["answer"]["title"]
	_back_line_desc.text = editable_card["answer"]["description"]

func _set_button_title(var title : String) -> void:
	_enter_button_title.text = title

func _on_change_deck_pressed(_button : Control) -> void:
	emit_signal("change_deck_requested", _button)

func _on_add_image_pressed(_button : Control) -> void:
	match _current_focus:
		"FRONT":
			_front_line.show_image()
		"BACK":
			_back_line.show_image()

func _on_enter_button_pressed(_button : Control) -> void:
	var _valid_card : bool = true
	
	var _question : Dictionary = {
		"title" : TEXTFORMAT.remove_unnecessary_space(_front_line_edit.text),
	}
	var _answer : Dictionary = {
		"title" : TEXTFORMAT.remove_unnecessary_space(_back_line_edit.text),
		"description" : TEXTFORMAT.remove_unnecessary_space(_back_line_desc.text)
	}
	
	if _question["title"] == "" or _answer["title"] == "" or !USERDATA.current_deck_data:
		_valid_card = false
	
	if _valid_card:
		match status:
			"CREATOR":
				emit_signal("update_history", "ADD")
				emit_signal("new_card", _question, _answer, USERDATA.current_deck_data["deck_id"])
			"EDITOR":
				emit_signal("edit_card", _question, _answer, editable_card, false, true)
				emit_signal("go_to_deck_screen_requested", null)
	else:
		print("FICHA INVALIDA")

func _on_delete_button_pressed(var _button: Control) -> void:
	emit_signal("delete_card", editable_card)
	emit_signal("go_to_deck_screen_requested", null)

func _on_permission_to_enter(var _permission : bool, var _origin : Control) -> void:
	match _origin.name.to_upper():
		"FRONTLINE":
			_front_line_permission = _permission
		"BACKLINE":
			_back_line_permission = _permission
	
	_enter_button._disable_button(false)
	if !_front_line_permission or !_back_line_permission:
		_enter_button._disable_button(true)

func _on_FrontEdit_focus_entered() -> void:
	_current_focus = "FRONT"

func _on_BackEdit_focus_entered() -> void:
	_current_focus = "BACK"
