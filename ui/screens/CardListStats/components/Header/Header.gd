extends Control

# warning-ignore:unused_signal
signal concept_order(orientation)
# warning-ignore:unused_signal
signal review_order(orientation)
# warning-ignore:unused_signal
signal hit_order(orientation)
# warning-ignore:unused_signal
signal effectivity_order(orientation)

onready var concept_button = $MarginContainer/Content/Concept as Control

onready var _content = $MarginContainer/Content as Control

func _ready() -> void: 
	for _c in _content.get_children():
		if _c.is_in_group("INDEXER"):
			_c.connect("switch_others_to_front", self, "_on_switch_index_to_front")
			_c.connect("set_order", self, "_on_set_order")

func _on_set_order(var _order : String, var _orientation : String) -> void:
	emit_signal(_order.to_lower() + "_order", _orientation)

func _on_switch_index_to_front(var _index : Control) -> void:
	for _c in _content.get_children():
		if _c.is_in_group("INDEXER"):
			if _c == _index:
				pass #_set_order(_index.order_by)
			else:
				if _c.side == "BACK":
					_c.back_action()
					_c.start()
