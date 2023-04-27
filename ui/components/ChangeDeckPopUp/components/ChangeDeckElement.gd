extends "res://ui/components/ButtonBase/ButtonBase.gd"

# warning-ignore:unused_signal
signal pressed(deck)

onready var _title_front : Label = $Pivot/Front/MarginContainer/Title
onready var _title_back : Label = $Pivot/Back/MarginContainer/Title

var title : String
var id : int

func _ready():
	_set_values(title)

func _set_values(_title : String) -> void:
	_title_front.text = _title
	_title_back.text = _title

func back_action() -> void:
	flip_timer_player.stop()
	button_base_player.play("FLIP_TO_FRONT")
	
	emit_signal("pressed", self)
