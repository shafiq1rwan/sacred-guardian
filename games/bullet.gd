extends Area2D

var TRAVELLED_DISTANCE = 0

func _physics_process(delta):
	const RANGE = 1200
	const SPEED = 500
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	TRAVELLED_DISTANCE += SPEED * delta
	if TRAVELLED_DISTANCE > RANGE:
		queue_free()

func _on_body_entered(_body):
	queue_free()
