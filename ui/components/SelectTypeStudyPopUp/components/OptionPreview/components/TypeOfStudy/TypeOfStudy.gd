extends Control

signal daily_study_requested(card_count)
signal custom_study_requested(card_count)

onready var types_container = $TypesContainer as MarginContainer
onready var types_count : int = types_container.get_children().size()

onready var _daily_study = $TypesContainer/DailyStudy as VBoxContainer
onready var _custom_study = $TypesContainer/CustomStudy as VBoxContainer
onready var _error_message_container = $ErrorMessage as MarginContainer
onready var _error_message = $ErrorMessage/Message as Label

func _ready() -> void:
	_daily_study.connect("daily_study_requested", self, "_on_daily_study_requested")
	_custom_study.connect("custom_study_requested", self, "_on_custom_study_requested")

func start(var _s_option : Dictionary) -> void:
	if CARDCULATIONS.calculated_all_cards_count(USERDATA.current_deck_data) >= _s_option["min_cards"]:
		types_container.visible = true
		_error_message_container.visible = false
		
		_daily_study.start(_s_option)
		_custom_study.start(_s_option)
	else:
		_error_message_container.visible = true
		types_container.visible = false
		
		_error_message.text = "Necesitas al menos " + str(_s_option["min_cards"]) + " ficha(s) para realizar este tipo de practica"

func set_values(var _active_type_id : int ) -> void:
	for _t in types_container.get_children():
		_t.visible = false
	
	types_container.get_children()[_active_type_id].visible = true

func _on_daily_study_requested(var _card_count : int) -> void:
	emit_signal("daily_study_requested", _card_count)

func _on_custom_study_requested(var _card_count : int) -> void:
	emit_signal("custom_study_requested", _card_count)
