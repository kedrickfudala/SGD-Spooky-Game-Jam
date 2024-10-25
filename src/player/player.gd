extends CharacterBody2D
class_name Player

@onready var world = get_parent()

@onready var player_hud : PackedScene = preload("res://src/ui/player_hud.tscn")
@onready var player_hud_inst : Object = null

@onready var sprite : Object = $Sprite2D
@onready var camera : Object = $Camera2D
@onready var animation_player : Object = $AnimationPlayer
@onready var combo_area : Object = $ComboArea
@onready var sfx_jump : AudioStreamPlayer = $SFX_Jump
@onready var sfx_score : AudioStreamPlayer = $SFX_Score
@onready var score_counter_timer : Object = $ScoreCounterTimer
@onready var combo_counter_timer : Object = $ComboCounterTimer
@onready var combo_runout_timer : Object = $ComboRunoutTimer

@onready var score : int = 0
@onready var combo : int = 0
@onready var combo_multiplier : float = 1.0

@onready var jumps : int = 2
@onready var drops : int = 1

func _ready():
	sprite.rotation_degrees = 0
	spawn_player_hud()
	combo_runout_timer.one_shot = true
	combo_runout_timer.set_wait_time(1)
	score_counter_timer.set_wait_time(.2)
	score_counter_timer.start()
	animation_player.play("cat_skating")
	
func _physics_process(_delta: float) -> void:
	camera.position_smoothing_speed = 3 + (world.speed / 100)
	if player_hud_inst:
			player_hud_inst.hud_label.text = str("Press SPACEBAR or W to Jump! You can DOUBLE JUMP!")
			player_hud_inst.hud_label.text += '\n' + str("Press SHIFT or S to Drop Down!")
			player_hud_inst.hud_label.text += '\n' + str("Score: ") + str(score)
			if combo_runout_timer.time_left > 0:
				player_hud_inst.hud_label.text += '\n' + str("Combo: ") + str(combo)
				player_hud_inst.hud_label.text += '\n' + str("    Multiplier: ") + str(combo_multiplier)
				player_hud_inst.hud_label.text += '\n' + str("    Time Left: ") + str(snapped(combo_runout_timer.time_left, 0.1))
	if world.game_start:
		handle_input()
		handle_movement()
		if velocity.x == 0:
			lose_game()
	if combo_runout_timer.time_left == 0:
		combo_counter_timer.stop()
	else:
		if combo_counter_timer.is_stopped():
			combo_counter_timer.start()

func handle_input():
	if is_on_floor():
		jumps = 2
		animation_player.play("cat_skating")
	if Input.is_action_just_pressed("jump") and jumps > 0:
		drops = 1
		sfx_jump.play()
		animation_player.play("cat_jump")
		velocity.y = -250
		jumps -= 1
	if Input.is_action_just_pressed("drop") and !is_on_floor() and drops > 0:
		velocity.y = 25
		drops -= 1

func handle_movement():
	velocity.x = world.speed
	velocity.y += 9.8
	move_and_slide()

func spawn_player_hud():
	player_hud_inst = player_hud.instantiate()
	add_child(player_hud_inst)

func lose_game():
	world.game_start = false
	score += combo
	combo = 0
	combo_multiplier = 1.0
	
	combo_runout_timer.stop()
	score_counter_timer.one_shot = true
	score_counter_timer.stop()
	combo_counter_timer.one_shot = true
	combo_counter_timer.stop()

	sprite.rotation_degrees = -90
	world.game_over()

func _on_combo_area_area_entered(area: Area2D) -> void:
	var object = area.get_parent()
	combo += object.score_value * combo_multiplier
	combo_runout_timer.start(combo_runout_timer.time_left + object.time_value)
	sfx_score.play()

func _on_score_counter_timer_timeout() -> void:
	score += 1

func _on_combo_counter_timer_timeout() -> void:
	combo_multiplier += .1

func _on_combo_runout_timer_timeout() -> void:
	score += combo
	combo = 0
	combo_multiplier = 1.0
