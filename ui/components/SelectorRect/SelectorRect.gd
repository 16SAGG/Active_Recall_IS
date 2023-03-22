extends Control

const DICT_POSITION = {
	'HOME': Vector2(16,216),
	'DECK': Vector2(16,280),
	'PRACTICE': Vector2(16,344),
	'STATS': Vector2(16,408),
	'SETTINGS': Vector2(16,472),
}

const TRANSITION_DURATION : float = 0.4

onready var _tween = $Tween as Tween

var anim_ready : bool = true

func _ready():
	print("SelectorRECT WANTS TO BE A FLOAT IN UI CORE. IS BETTER TO HIM STAY IN THIS PLACE BECAUSE NOT ONLY THE SIDE BAR CAN CHANGE THE SCENE")
	go_to('HOME')

func go_to(destiny : String) -> void:
	print('The Selector Rect will be able to move to ' + destiny)
	anim_ready = false
	_tween.interpolate_property(
		self, 
		"rect_position",
		rect_position,
		DICT_POSITION[destiny],
		TRANSITION_DURATION,
		Tween.TRANS_CUBIC, #BACK; CIRC; CUBIC; QUAD;
		Tween.EASE_IN_OUT
	)
	_tween.start()

func _on_Tween_tween_completed(object, key) -> void:
	anim_ready = true
	
	var _unused_vars = [object, key] #To avoid warnings

