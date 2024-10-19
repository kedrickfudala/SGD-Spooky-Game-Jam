extends Node2D
class_name World

@onready var player : PackedScene = preload("res://src/player/player.tscn")
@onready var player_inst : Object = null

@onready var level_counter : int = 0

@onready var level_0 : PackedScene = preload("res://src/levels/level_0.tscn")

@onready var levels = [level_0]


func _ready():
	spawn_player()
	for x in 3:
		spawn_random_level()
	pass

func spawn_player():
	player_inst = player.instantiate()
	player_inst.global_position = Vector2(0,0)
	add_child(player_inst)

func spawn_level(id : int):
	var level_inst = levels[id].instantiate()
	level_inst.global_position = Vector2(level_counter * 48 * 8,0)
	call_deferred("add_child", level_inst)
	level_counter += 1
	
func spawn_random_level():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0, len(levels) - 1)
	spawn_level(num)
