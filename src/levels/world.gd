extends Node2D
class_name World

@onready var player : PackedScene = preload("res://src/player/player.tscn")
@onready var player_inst : Object = null

@onready var game_start : bool = false

@onready var level_0 : PackedScene = preload("res://src/levels/level_0.tscn")
@onready var level_1 : PackedScene = preload("res://src/levels/level_1.tscn")
@onready var level_2 : PackedScene = preload("res://src/levels/level_2.tscn")
@onready var level_3 : PackedScene = preload("res://src/levels/level_3.tscn")
@onready var level_4 : PackedScene = preload("res://src/levels/level_4.tscn")
@onready var level_5 : PackedScene = preload("res://src/levels/level_5.tscn")
@onready var level_6 : PackedScene = preload("res://src/levels/level_6.tscn")
@onready var level_7 : PackedScene = preload("res://src/levels/level_7.tscn")
@onready var level_8 : PackedScene = preload("res://src/levels/level_8.tscn")
@onready var level_9 : PackedScene = preload("res://src/levels/level_9.tscn")

@onready var level_insts = []
@onready var level_segments = [level_0,level_1,level_2,level_3,level_4,level_5,level_6,level_7,level_8,level_9]

@onready var speed : float = 100

func _ready():
	spawn_player()
	spawn_level(0, 0)
	#spawn_random_level(1 * 512)
	spawn_level(2, 1 * 512)
	spawn_random_level(2 * 512)
	game_start = true

func _physics_process(_delta: float) -> void:
	speed += 0.02
	#print(speed)

func spawn_player():
	player_inst = player.instantiate()
	player_inst.global_position = Vector2(0,0)
	add_child(player_inst)

func spawn_level(id : int, x_offset : int):
	if player_inst:
		var level_inst = level_segments[id].instantiate()
		level_inst.global_position = Vector2(x_offset,level_inst.right_height * 16)
		add_child(level_inst)
		level_insts.append(level_inst)
	else:
		print("ERROR: Player inst does not exist")
	
func spawn_random_level(x_offset : int):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(1, len(level_segments) - 1)
	spawn_level(num, x_offset)

func game_over():
	print("game over")
	game_start = false
	get_parent().spawn_gameover()
