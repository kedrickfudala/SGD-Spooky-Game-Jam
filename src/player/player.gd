extends CharacterBody2D
class_name Player

@onready var world = get_parent()

@onready var player_hud : PackedScene = preload("res://src/ui/player_hud.tscn")
@onready var player_hud_inst : Object = null

@onready var camera : Object = $Camera2D
@onready var animation_player : Object = $AnimationPlayer
@onready var sfx_jump: AudioStreamPlayer = $SFX_Jump
@onready var sfx_score: AudioStreamPlayer = $SFX_Score
@onready var combo_timer : Object = $ComboTimer

@onready var score : int = 0
@onready var jumps : int = 2

func _ready():
	spawn_player_hud()
	combo_timer.set_wait_time(5999)
	combo_timer.start()
	animation_player.play("cat_skating")
	
func _physics_process(_delta: float) -> void:
	if world.game_start:
		if player_hud_inst:
			player_hud_inst.score_label.text = str("Score: ") + str(score)
			player_hud_inst.combo_label.text = str("Combo Timer: ") + str(snapped(combo_timer.time_left, 0.1))
		handle_input()
		handle_movement()

func handle_input():
	if is_on_floor():
		jumps = 2
		animation_player.play("cat_skating")
	if Input.is_action_just_pressed("jump") and jumps > 0:
		sfx_jump.play()
		animation_player.play("cat_jump")
		velocity.y = -250
		jumps -= 1

func handle_movement():
	velocity.y += 9.8
	move_and_slide()

func spawn_player_hud():
	player_hud_inst = player_hud.instantiate()
	add_child(player_hud_inst)

func _on_combo_timer_timeout() -> void:
	world.game_over()

func _on_combo_area_area_entered(area: Area2D) -> void:
	var object = area.get_parent()
	score += object.score_value
	combo_timer.start(combo_timer.time_left + object.time_value)
	sfx_score.play()
