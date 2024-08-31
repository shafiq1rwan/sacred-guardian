extends CharacterBody2D

@onready var ancient_tree = $"../AncientTree"
@onready var hp_skull_blue = $HPSkullBlue
@export var detection_radius: float = 300.0 # The range within which the enemy detects the player
@export var shoot_interval: float = 2.0 # Time between shots
@export var bullet_scene: PackedScene # The bullet scene to shoot
@export var bullet_speed: float = 400.0 # Speed of the bullet
@onready var death_sfx = $DeathSFX

signal mob_dead

var SPEED_MOB = 3000.0
var HP = 5
var player: Node2D
var time_since_last_shot: float = 0.0

func _ready():
	hp_skull_blue.value = HP
	# Assuming the player is named "Player" in the scene
	player = get_parent().get_node("Player")


func _physics_process(delta):
	var direction = global_position.direction_to(ancient_tree.global_position)
	velocity = direction * SPEED_MOB * delta
	move_and_slide()

#func _on_detection_area_body_entered(body):
	#SPEED_MOB = 0.0
	##if(body.name == "Player"):
		##shoot()
#
#func _on_detection_area_body_exited(body):
	#SPEED_MOB = 3000.00
	
func take_damage():
	HP -= 1
	hp_skull_blue.value = HP
	
	if(HP == 0):
		death_sfx.play()

func _on_death_sfx_finished():
	queue_free()
