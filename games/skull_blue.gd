extends CharacterBody2D

@onready var ancient_tree = $"../AncientTree"
@onready var player = $"../Player"
@onready var hp_skull_blue = $HPSkullBlue
@onready var death_sfx = $DeathSFX

var HP = 5

func _ready():
	hp_skull_blue.value = HP

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * GameManager.SPEED_MOB_IMP * delta
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
	GameManager.TOTAL_DEFEATED_MONSTER += 1
	GameManager.SCORE += 1
