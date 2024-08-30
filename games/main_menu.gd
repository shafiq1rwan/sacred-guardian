extends Control

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://games/lobby.tscn")

func _on_setting_button_pressed():
	get_tree().change_scene_to_file("res://games/settings.tscn")
