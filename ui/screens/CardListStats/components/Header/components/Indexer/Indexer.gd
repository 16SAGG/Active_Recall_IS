extends "res://ui/components/ButtonBase/ButtonBase.gd"

signal switch_others_to_front(my_self)
signal set_order(order, orientation)

export var new_title : String = "Concepto"
export (String, "CONCEPT", "REVIEW", "HIT", "EFFECTIVITY") var order_by

onready var _front_title = $Pivot/Front/MarginContainer/Title as Label
onready var _back_title = $Pivot/Back/MarginContainer/Title as Label
onready var _back_box = $Pivot/Back/Style/BackgroundBox as Control

onready var _current_theme = USERDATA.current_theme as String

var _active : bool = false

func _ready() -> void:
	_front_title.text = new_title
	_back_title.text = new_title

func start():
	_back_box.modulate = THEMES.DICT_THEMES[_current_theme]['PRIMARY']

func front_action() -> void:
	if flip_timer_active:
		flip_timer_player.play("FLIP_TIMER")
	button_base_player.play("FLIP_TO_BACK")
	_active = true

func _on_BackTrigger_pressed() -> void:
	match _active:
		false:
			_back_box.modulate = THEMES.DICT_THEMES[_current_theme]['PRIMARY']
			emit_signal("set_order", order_by, "ascending")
		true:
			_back_box.modulate = THEMES.DICT_THEMES[_current_theme]['DANGER']
			emit_signal("set_order", order_by, "descending")
	
	_active = !_active

# warning-ignore:unused_argument
func _on_Indexer_back_flip(button) -> void:
	emit_signal("switch_others_to_front", self)
	_on_BackTrigger_pressed()
