extends Node2D

func _on_backto_lobby_pressed():
	get_tree().change_scene_to_file("res://games/lobby.tscn")
