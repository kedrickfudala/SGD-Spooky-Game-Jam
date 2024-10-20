extends CharacterBody2D
class_name Player

@onready var world = get_parent()

@onready var player_hud : PackedScene = preload("res://src/ui/player_hud.tscn")
@onready var player_hud_inst : Object = null

@onready var animation_player : Object = $AnimationPlayer
@onready var combo_timer : Object = $ComboTimer

@onready var score : int = 0
@onready var combo : float = 0.0

@onready var jumps : int = 2

func _ready():
	spawn_player_hud()
	
func _physics_process(_delta: float) -> void:
	if player_hud_inst:
		player_hud_inst.score_label.text = str("Score: ") + str(score)
		player_hud_inst.combo_label.text = str("Combo: ") + str(combo)
	handle_input()
	handle_movement()
	
	print(global_position)

func handle_input():
	if is_on_floor():
		jumps = 2
	if Input.is_action_just_pressed("jump") and jumps > 0:
		velocity.y = -250
		jumps -= 1

func handle_movement():
	velocity.y += 9.8
	move_and_slide()

func spawn_player_hud():
	player_hud_inst = player_hud.instantiate()
	add_child(player_hud_inst)
