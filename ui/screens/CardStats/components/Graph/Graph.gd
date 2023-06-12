extends MarginContainer

onready var _pie_chart = $MarginContainer/Layout/PieChart as Control

func set_pie_chart(var _item_value : Array) -> void:
	_pie_chart.item_value = _item_value
	
	_pie_chart.update()
