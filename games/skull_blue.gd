extends CharacterBody2D

@onready var ancient_tree = $"../AncientTree"
@onready var detection_area = $DetectionArea
@onready var hp_skull_blue = $HPSkullBlue

var SPEED_MOB = 3000.0
var HP = 5

func _ready():
	hp_skull_blue.value = HP

func _physics_process(delta):
	var direction = global_position.direction_to(ancient_tree.global_position)
	velocity = direction * SPEED_MOB * delta
	move_and_slide()

func _on_detection_area_body_entered(body):
	SPEED_MOB = 0.0
	#if(body.name == "Player"):
		#shoot()

func _on_detection_area_body_exited(body):
	SPEED_MOB = 3000.00
	
func take_damage():
	HP -= 1
	hp_skull_blue.value = HP
	
	if(HP == 0):
		queue_free()
		
func shoot():
	const BULLETMOB = preload("res://games/skull_attack.tscn")
	var new_bullet = BULLETMOB.instantiate()
	new_bullet.global_position = $ShootingPointMob.global_position
	#new_bullet.global_rotation = $ShootingPointMob.global_rotation
	$ShootingPointMob.add_child(new_bullet)
