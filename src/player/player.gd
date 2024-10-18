extends CharacterBody2D
class_name Player

@onready var score : int = 0
@onready var combo : float = 0.0

func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	velocity.y += 400
	
