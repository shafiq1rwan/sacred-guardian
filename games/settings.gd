extends Control
@export var bus_name: String
var bgm = AudioServer.get_bus_index("BGM")

func _ready():
	%VolumeSlider.value = db_to_linear(bgm)
	
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://games/main_menu.tscn")

func _on_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(bgm, linear_to_db(value))
