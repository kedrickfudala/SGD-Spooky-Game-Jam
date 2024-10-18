extends CharacterBody2D
class_name Player

@onready var score : int = 0
@onready var combo : float = 0.0

@onready var jumps : int = 2

func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	handle_input()
	handle_movement()

func handle_input():
	if is_on_floor():
		jumps = 2
	if Input.is_action_just_pressed("jump") and jumps > 0:
		velocity.y = -200
		jumps -= 1

func handle_movement():
	velocity.x = 50
	velocity.y += 9.8
	move_and_slide()
