extends Control

const STYLE_LOGO = preload ("res://ui/components/UISideBar/components/MiniSideButton/MiniSideButton_styles/StyleLogo.tscn")
const STYLE_ACTION = preload ("res://ui/components/UISideBar/components/MiniSideButton/MiniSideButton_styles/StyleAction.tscn")
const STYLE_HOME = preload ("res://ui/components/UISideBar/components/MiniSideButton/MiniSideButton_styles/StyleHome.tscn")
const STYLE_DECK = preload ("res://ui/components/UISideBar/components/MiniSideButton/MiniSideButton_styles/StyleDeck.tscn")
const STYLE_PRACTICE = preload ("res://ui/components/UISideBar/components/MiniSideButton/MiniSideButton_styles/StylePractice.tscn")
const STYLE_STATS = preload ("res://ui/components/UISideBar/components/MiniSideButton/MiniSideButton_styles/StyleStatistics.tscn")
const STYLE_SETTINGS = preload ("res://ui/components/UISideBar/components/MiniSideButton/MiniSideButton_styles/StyleSettings.tscn")

enum style {LOGO, ACTION, HOME, DECK, PRACTICE, STATS, SETTINGS}

export (style) var current_style = style.LOGO

onready var _style = $Style as Control

func _ready() -> void:
	_setting_style(current_style)

func _setting_style(style) -> void:
	var _new_style : Control
	match style:
		0:
			_new_style = STYLE_LOGO.instance()
		1: 
			_new_style = STYLE_ACTION.instance()
		2:
			_new_style = STYLE_HOME.instance()
		3:
			_new_style = STYLE_DECK.instance()
		4:
			_new_style = STYLE_PRACTICE.instance()
		5:
			_new_style = STYLE_STATS.instance()
		6:
			_new_style = STYLE_SETTINGS.instance()
	_style.add_child(_new_style)
	
