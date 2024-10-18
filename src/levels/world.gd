extends Node2D
class_name World

@onready var player : PackedScene = preload("res://src/player/player.tscn")
@onready var player_inst : Object = null


func _ready():
	pass

func spawn_player():
	player_inst = player.instantiate()
	player_inst.global_position = Vector2(0,0)
	add_child(player_inst)
