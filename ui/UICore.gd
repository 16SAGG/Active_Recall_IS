extends Control

#UICore is the script that change scenes and shows/hides popup's

onready var _ui_side_bar = $Layout/UISideBar as Control

onready var _home = $Layout/Screens/Home as Control

onready var _action_pop_up = $ActionPopUp as Control
onready var _shadow = $Shadow as Control
onready var _selector_rect = $SelectorRect as Control
onready var _new_deck_pop_up = $NewDeckPopUp as Control


func _ready() -> void:
	_ui_side_bar.connect("go_to_home_screen_requested", self, "_on_home_requested")
	_ui_side_bar.connect("show_action_pop_up_requested", self, "_on_show_action_pop_up_requested")
	_action_pop_up.connect("go_to_new_card_screen_requested", self, "_on_new_card_requested")
	_action_pop_up.connect("create_new_deck_box_requested", self, "_on_create_new_deck_requested")
	_new_deck_pop_up.connect("new_deck", self, "_on_new_deck")
	_action_pop_up.connect("hide_action_pop_up_requested", self, "_on_hide_action_pop_up_requested")
	_new_deck_pop_up.connect("hide_new_deck_pop_up_requested", self, "_on_hide_new_deck_pop_up_requested")
	_ui_side_bar.connect("go_to_deck_screen_requested", self, "_on_deck_requested")
	_home.connect("go_to_deck_screen_requested", self, "_on_deck_requested")
	_home.connect("go_to_practice_screen_requested", self, "_on_practice_requested")
	_ui_side_bar.connect("go_to_practice_screen_requested", self, "_on_practice_requested")
	_ui_side_bar.connect("go_to_statistics_screen_requested", self, "_on_statistics_requested")
	_ui_side_bar.connect("go_to_settings_screen_requested", self, "_on_settings_requested")

func _on_home_requested() -> void:
	_change_screen("HOME")

func _on_new_card_requested(_deck : Control) -> void:
	if _action_pop_up.showed: 
		_action_pop_up.animation_player.play("HIDE")

func _on_create_new_deck_requested()-> void:
	if not _new_deck_pop_up.showed:
		_new_deck_pop_up.animation_player.play("SHOW")
		_shadow.animation_player.play("SHOW")
		if _action_pop_up.showed: 
			_action_pop_up.animation_player.play("HIDE")

	
func _on_new_deck(_title : String) -> void:
	if _new_deck_pop_up.showed:
		_new_deck_pop_up.animation_player.play("HIDE")
		_shadow.animation_player.play("HIDE")
		var _dict : Dictionary = {
			"user_id" : 1,
			"title" : _title,
		}
		USERDATA.commit_data("Deck", _dict)
		_home.start()

func _on_show_action_pop_up_requested() -> void:
	_change_screen("HOME")
	if not _action_pop_up.showed: 
		_action_pop_up.animation_player.play("SHOW")

func _on_hide_action_pop_up_requested() -> void:
	if _action_pop_up.showed: 
		_action_pop_up.animation_player.play("HIDE")

func _on_hide_new_deck_pop_up_requested() -> void:
	if _new_deck_pop_up.showed:
		_new_deck_pop_up.animation_player.play("HIDE")
		_shadow.animation_player.play("HIDE")

func _on_deck_requested(_deck : Control) -> void:
	_change_screen("DECK")

func _on_practice_requested(_deck : Control) -> void:
	_change_screen("PRACTICE")

func _on_statistics_requested(_deck : Control) -> void:
	_change_screen("STATS")

func _on_settings_requested(_deck : Control) -> void:
	_change_screen("SETTINGS")

func _change_screen(_screen : String) -> void:
	_selector_rect.go_to(_screen)
