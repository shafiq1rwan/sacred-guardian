extends CharacterBody2D
@onready var player_hp: ProgressBar = $HUD/PlayerHP
@onready var ancient_tree_hp: ProgressBar = $HUD/AncientTreeHP


func _ready() -> void:
	player_hp.value = GameManager.HP_PLAYER
	ancient_tree_hp.value = GameManager.ANCIENTTREE_HP

func _physics_process(_delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * GameManager.SPEED_PLAYER
	
	move_and_slide()
	
	if velocity.length() > 0.00:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
