extends Node2D
@onready var pause_menu = %PauseMenu
@onready var wave_label = $Player/HUD/WaveLabel
@onready var score_label = $Player/HUD/ScoreLabel

func _on_backto_lobby_pressed():
	get_tree().change_scene_to_file("res://games/lobby.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause_menu.visible = true
		Engine.time_scale = 0
		GameManager.IS_PAUSED = true
	
	wave_label.text = "Wave Level: " + str(GameManager.CURRENT_WAVE_LEVEL)
	score_label.text = "Score: " + str(GameManager.SCORE)
	
func _on_resume_button_pressed():
	pause_menu.visible = false
	Engine.time_scale = 1
	GameManager.IS_PAUSED = false

func _on_lobby_button_pressed():
	get_tree().change_scene_to_file("res://games/lobby.tscn")

func _on_timer_timeout():
	if GameManager.TOTAL_MOB_ONSTAGE <= GameManager.TOTAL_MINIMUM_MOB:
		spawnMob()
	
	if GameManager.TOTAL_DEFEATED_MONSTER == GameManager.TOTAL_MOB_ONSTAGE:
		GameManager.CURRENT_WAVE_LEVEL += 1
		GameManager.TOTAL_MOB_ONSTAGE = 0
		GameManager.TOTAL_DEFEATED_MONSTER = 0
		GameManager.TOTAL_MINIMUM_MOB += 2

func spawnMob():
	var spawnMOB = preload("res://games/skull_blue.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	spawnMOB.global_position = %PathFollow2D.global_position
	add_child(spawnMOB)
	GameManager.TOTAL_MOB_ONSTAGE += 1
