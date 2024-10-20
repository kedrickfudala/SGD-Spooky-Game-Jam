extends Node2D
class_name World

@onready var player : PackedScene = preload("res://src/player/player.tscn")
@onready var player_inst : Object = null

@onready var game_start : bool = false

@onready var level_0 : PackedScene = preload("res://src/levels/level_0.tscn")

@onready var map_segments = [level_0]

@onready var speed : float = 2

func _ready():
	spawn_player()
	spawn_random_level(0)
	spawn_random_level(1 * 512)
	spawn_random_level(2 * 512)
	game_start = true

func _physics_process(delta: float) -> void:
	speed += 0.002
	print(speed)

func spawn_player():
	player_inst = player.instantiate()
	player_inst.global_position = Vector2(0,0)
	add_child(player_inst)

func spawn_level(id : int, x_offset : int):
	if player_inst:
		var level_inst = map_segments[id].instantiate()
		level_inst.global_position = Vector2(x_offset,0)
		#call_deferred("add_child", level_inst)
		add_child(level_inst)
		return level_inst
	else:
		print("ERROR: Player inst does not exist")
	
func spawn_random_level(x_offset):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0, len(map_segments) - 1)
	spawn_level(num, x_offset)
