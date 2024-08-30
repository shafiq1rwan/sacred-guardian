extends Area2D

var TRAVELLED_DISTANCE = 0
@export var BULLET_SPEED = 100

func _physics_process(delta):
	const RANGE = 1200
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * BULLET_SPEED * delta
	
	TRAVELLED_DISTANCE += BULLET_SPEED * delta
	if TRAVELLED_DISTANCE > RANGE:
		queue_free()

func _on_body_entered(body):
	queue_free()
