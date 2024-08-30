extends Node2D
@onready var pause_menu = %PauseMenu

func _on_backto_lobby_pressed():
	get_tree().change_scene_to_file("res://games/lobby.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause_menu.visible = true
		Engine.time_scale = 0
		GameManager.IS_PAUSED = true

func _on_resume_button_pressed():
	pause_menu.visible = false
	Engine.time_scale = 1
	GameManager.IS_PAUSED = false

func _on_lobby_button_pressed():
	get_tree().change_scene_to_file("res://games/lobby.tscn")

func _on_timer_timeout():
	if GameManager.TOTAL_MOB_ONSTAGE <= GameManager.TOTAL_MINIMUM_MOB:
		spawnMob()

func spawnMob():
	var spawnMOB = preload("res://games/skull_blue.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	spawnMOB.global_position = %PathFollow2D.global_position
	add_child(spawnMOB)
	GameManager.TOTAL_MOB_ONSTAGE += 1
