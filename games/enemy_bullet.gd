extends Area2D

@export var speed: float = 400.0
var direction: Vector2

func _ready():
	# Set the bullet to move in the direction it is facing
	direction = direction.normalized()

func _process(delta: float):
	# Move the bullet in the specified direction
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		queue_free()
	
	if body.has_method("take_damage_from_enemies"):
		body.take_damage_from_enemies()
