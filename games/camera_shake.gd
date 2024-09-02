# CameraShake.gd
extends Camera2D

@export var shake_duration: float = 0.5
@export var shake_magnitude: float = 10.0

var shake_time: float = 0.0
var original_position: Vector2

func _ready():
	original_position = position

func _process(delta: float):
	if shake_time > 0:
		shake_time -= delta
		position = original_position + Vector2(randf() - 0.5, randf() - 0.5) * shake_magnitude
	else:
		position = original_position

func start_shake():
	shake_time = shake_duration
