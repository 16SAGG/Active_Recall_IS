extends Control

const DICT_POSITION = {
	'HOME': Vector2(16,216),
	'CARD': Vector2(16,216),
	'DECK': Vector2(16,280),
	'PRACTICE': Vector2(16,344),
	'FLASH_CARD': Vector2(16,344),
	'TEST': Vector2(16,344),
	'STATS': Vector2(16,408),
	'DECK_STATS' : Vector2(16,408),
	'CARD_LIST_STATS' : Vector2(16,408),
	'DECK_SETTINGS': Vector2(16,472),
	'USER_SETTINGS': Vector2(16,472),
	
}

const TRANSITION_DURATION : float = 0.4

onready var _tween = $Tween as Tween

var anim_ready : bool = true

func _ready():
	go_to('HOME')

func go_to(destiny : String) -> void:
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

