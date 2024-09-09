extends CharacterBody2D

#@export var bullet_scene: PackedScene # Drag and drop the Bullet.tscn here
const bullet_scene = preload("res://games/enemy_bullet.tscn")
@export var shoot_interval: float = 3.0
@export var bullet_offset: Vector2 = Vector2(0, 0) # Offset for bullet spawning
#@onready var ancient_tree = $"../AncientTree"

var player: Node2D
var time_since_last_shot: float = 0.0
var HP = 5

func _ready():
	# Find the player in the scene (make sure the player node is named "Player")
	player = get_node("/root/Game/Player")
	$MobHP.value = GameManager.MOB_HP
	add_to_group("enemies")

func _process(delta: float):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * GameManager.SPEED_MOB * delta
	move_and_slide()
	
	time_since_last_shot += delta
	
	if time_since_last_shot >= shoot_interval:
		shoot_bullet()
		time_since_last_shot = 0.0

func shoot_bullet():
	if not player:
		return
	# Instance the bullet and set its position and direction
	var bullet = bullet_scene.instantiate()
	bullet.position = position + bullet_offset
	bullet.rotation = rotation
	
	# Calculate direction towards the player
	bullet.direction = (player.position - position).normalized()
	
	# Add the bullet to the scene
	get_parent().add_child(bullet)

func take_damage():
	HP -= 1
	$MobHP.value = HP
	$HurtPlayer.play("hurt")
	
	if(HP == 0):
		$DeathSFX.play()

func _on_death_sfx_finished() -> void:
	queue_free()
	GameManager.TOTAL_DEFEATED_MONSTER += 1
	GameManager.SCORE += 1
