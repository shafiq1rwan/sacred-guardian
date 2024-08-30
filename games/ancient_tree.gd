extends StaticBody2D

var HP = 100.00
@onready var tree_hp = $TreeHP

# Called when the node enters the scene tree for the first time.
func _ready():
	tree_hp.value = HP
