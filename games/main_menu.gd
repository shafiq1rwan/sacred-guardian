extends Control

@onready var bgm: AudioStreamPlayer = $CanvasLayer/BGM

func _ready() -> void:
	bgm.play()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://games/game.tscn")

func _on_setting_button_pressed():
	get_tree().change_scene_to_file("res://games/settings.tscn")
