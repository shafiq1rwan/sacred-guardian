extends CharacterBody2D

@export var attack_damage: int = 10
@export var attack_cooldown: float = 0.5
@export var attack_duration: float = 0.2

var can_attack: bool = true
var is_attacking: bool = false

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
	
	if Input.is_action_pressed("melee") and can_attack:
		perform_attack()

func take_damage_from_enemies():
	# Your logic for reducing player health
	var camera = get_viewport().get_camera_2d()
	camera.start_shake()
	
	GameManager.HP_PLAYER -= 2
	%PlayerHP.value = GameManager.HP_PLAYER

func perform_attack():
	if not is_attacking:
		is_attacking = true
		can_attack = false

		# Play attack animation if available
		#var anim = $AnimationPlayer
		#if anim.has_animation("attack"):
			#anim.play("attack")
		
		# Activate the AttackArea for a short duration
		$AttackArea.set_monitoring(true)
		await(get_tree().create_timer(attack_duration))
		$AttackArea.set_monitoring(false)
		
		is_attacking = false
		await(get_tree().create_timer(attack_cooldown))
		can_attack = true

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"): # Make sure enemies are in an 'enemies' group
		apply_damage(body)

func apply_damage(body):
	if body.has_method("take_damage"):
		body.take_damage()
