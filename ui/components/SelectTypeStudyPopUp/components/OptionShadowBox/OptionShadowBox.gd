extends Control

onready var _title_label = $Title as Label

var title : String
var dir : String

func _ready() -> void:
	_set_values(title)

func _set_values (var _title : String) -> void:
	_title_label.text = title

func hide() -> void:
	self.modulate = "00ffffff"

func show() -> void:
	self.modulate = "ffffff"
