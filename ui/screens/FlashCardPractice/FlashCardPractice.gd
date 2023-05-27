extends "res://ui/screens/PracticeOptionBase.gd"

onready var _header = $MarginContainer/Layout/Header as Label

onready var _left_button = $MarginContainer/Layout/CardPreview/LeftButton as Control
onready var _base = $MarginContainer/Layout/CardPreview/Base
onready var _right_button = $MarginContainer/Layout/CardPreview/RightButton as Control

onready var _card_button = $CardButton as Control
onready var _card_anim = $CardAnim as AnimationPlayer

var _side_button_state : String = "ANSWERING"
var _current_card : Dictionary
var _cover_card : Dictionary

func _ready() -> void:
	_left_button.connect("clicked", self, "_on_left_button_clicked")
	_base.connect("show_finished", self, "_on_base_showed")
	_right_button.connect("clicked", self, "_on_right_button_clicked")
	_card_button.connect("first_flip", self, "_on_first_flip_has_happened")

func start() -> void:
	if _study_array:
		_study_lap()
	else:
		_hits = 0
		_congrats_suporter(true)

func _study_lap() -> void:
	_current_card = _study_array.pop_front()
	
	_header.change_text(USERDATA.current_deck_data["title"] + "(" + str(_hits) + " de " + str(_registered_array.size()) + ")")
	_cover_card = _generate_cover(_registered_array)
	
	_base.start()
	_card_button.start(_current_card["question"], _current_card["answer"], _cover_card["answer"])
	
	if _left_button.visible:
		_left_button.animation_player.play("HIDE_ICONS")
	if _right_button.visible:
		_right_button.animation_player.play("HIDE_ICONS")
	_left_button.set_icon("WRONG")
	_right_button.set_icon("CORRECT")
	
	_side_button_state = "ANSWERING"
	_card_anim.play("MOVE_TO_ORIGIN")

func _generate_cover(var _card_array : Array) -> Dictionary:
	var _cover : Dictionary
	var _options : Array = [true, false]
	
	_options.shuffle()
	
	_cover = _current_card
	match _options[0]:
		true:
			pass
		false:
			var _pot : Array = _card_array.duplicate()
			while(_cover["card_id"] == _current_card["card_id"]):
				_pot.shuffle()
				_cover = _pot[0]
			
			if _cover["answer"]["title"] == _current_card["answer"]["title"]:
				_cover["answer"]["title"] += " " + str(2) 
				print("ESTE")
	
	return _cover

func _on_first_flip_has_happened() -> void:
	_header.change_text("¿Verdadero o falso?")
	_left_button.animation_player.play("SHOW_ICONS")
	_right_button.animation_player.play("SHOW_ICONS")

func _side_button_behavior(var _side : String) -> void:
	match _side_button_state:
		"ANSWERING":
			var _correct_answer = "LEFT"
			if _current_card["card_id"] == _cover_card["card_id"]:
				_correct_answer = "RIGHT"
			
			if _correct_answer == _side:
				_header.change_text("Respuesta correcta")
				_card_button.show_answer("CORRECT")
				_current_card = _submit_answer(_current_card, "CORRECT")
				_hits += 1
			else:
				_header.change_text("Respuesta incorrecta")
				_card_button.show_answer("WRONG")
				_current_card = _submit_answer(_current_card, "WRONG")
				_study_array.append(_current_card)
			_left_button.set_icon("LEFT")
			_right_button.set_icon("RIGHT")
			_side_button_state = "CONTINUING"
			
			match _type_study:
				"CUSTOM":
					match _current_card["result"]:
						"CORRECT":
							_base.set_values(_current_card["question"]["title"], -1)
						"WRONG":
							_base.set_values(_current_card["question"]["title"], 0)
				"DAILY":
					_base.set_values(_current_card["question"]["title"], _current_card["space_btwn_sessions"])
		"CONTINUING":
			_header.change_text("Click para continuar")
			_card_anim.play("MOVE_TO_" + _side)
		"RESTARTING":
			start()

func _on_left_button_clicked() -> void:
	_side_button_behavior("LEFT")

func _on_right_button_clicked() -> void:
	_side_button_behavior("RIGHT")

func _on_CardAnim_animation_finished(anim_name) -> void:
	match anim_name:
		"MOVE_TO_ORIGIN":
			pass
		_:
			_side_button_state = "WAITING"
			_base.anim_player.play("SHOW")

func _on_base_showed() -> void:
	_side_button_state = "RESTARTING"
