extends Node2D
@onready var pause_menu = %PauseMenu
@onready var wave_label = $Player/HUD/WaveLabel
@onready var score_label = $Player/HUD/ScoreLabel

@export var enemy_scenes: Array = [preload("res://games/angry_shrom.tscn"), preload("res://games/skull_blue.tscn")]

func _ready() -> void:
	randomize() # Ensures more random results from randi()

func _on_backto_lobby_pressed():
	get_tree().change_scene_to_file("res://games/lobby.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause_menu.visible = true
		Engine.time_scale = 0
		GameManager.IS_PAUSED = true
	
	wave_label.text = "Wave Level: " + str(GameManager.CURRENT_WAVE_LEVEL)
	score_label.text = "Score: " + str(GameManager.SCORE)
	
	if GameManager.HP_PLAYER == 0:
		Engine.time_scale = 0
		%GameOver.visible = true
	
func _on_resume_button_pressed():
	pause_menu.visible = false
	Engine.time_scale = 1
	GameManager.IS_PAUSED = false

func _on_lobby_button_pressed():
	%GameOver.visible = false
	get_tree().change_scene_to_file("res://games/main_menu.tscn")

func _on_timer_timeout():
	if GameManager.TOTAL_MOB_ONSTAGE <= GameManager.TOTAL_MINIMUM_MOB:
		spawnMob()
	
	if GameManager.TOTAL_DEFEATED_MONSTER == GameManager.TOTAL_MOB_ONSTAGE:
		GameManager.CURRENT_WAVE_LEVEL += 1
		GameManager.TOTAL_MOB_ONSTAGE = 0
		GameManager.TOTAL_DEFEATED_MONSTER = 0
		GameManager.TOTAL_MINIMUM_MOB += 2

func spawnMob():
	# Select a random enemy from the array
	var random_index = randi() % enemy_scenes.size()
	var enemy_scene = enemy_scenes[random_index]
	
	# Instance the selected enemy
	var enemy_instance = enemy_scene.instantiate()
	%PathFollow2D.progress_ratio = randf()
	enemy_instance.global_position = %PathFollow2D.global_position
	add_child(enemy_instance)
	GameManager.TOTAL_MOB_ONSTAGE += 1
