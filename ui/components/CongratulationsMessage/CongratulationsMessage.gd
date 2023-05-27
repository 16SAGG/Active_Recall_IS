extends Control


onready var animation_player = $AnimationPlayer as AnimationPlayer


func _on_CongratulationsMessage_resized():
	self.rect_size = self.rect_min_size
