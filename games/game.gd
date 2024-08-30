extends Node2D
@onready var pause_menu = %PauseMenu

func _on_backto_lobby_pressed():
	get_tree().change_scene_to_file("res://games/lobby.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause_menu.visible = true

func _on_resume_button_pressed():
	pause_menu.visible = false
