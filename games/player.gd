extends CharacterBody2D

func _ready() -> void:
	%PlayerHP.value = GameManager.HP_PLAYER
	%AncientTreeHP.value = GameManager.ANCIENTTREE_HP

func _physics_process(_delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * GameManager.SPEED_PLAYER
	
	move_and_slide()
	
	if velocity.length() > 0.00:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")

func take_damage_from_enemies():
	# Your logic for reducing player health
	var camera = get_viewport().get_camera_2d()
	camera.start_shake()
	
	GameManager.HP_PLAYER -= 2
	%PlayerHP.value = GameManager.HP_PLAYER
