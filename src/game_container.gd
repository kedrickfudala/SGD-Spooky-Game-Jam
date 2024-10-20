extends Node2D
class_name GameContainer

@onready var main_menu : PackedScene = preload("res://src/ui/main_menu.tscn")
@onready var world : PackedScene = preload("res://src/levels/world.tscn")

func _ready():
	#spawn_main_menu()
	
	spawn_world()

func spawn_main_menu():
	var main_menu_inst = main_menu.instantiate()
	main_menu_inst.global_position = Vector2(0,0)
	add_child(main_menu_inst)

func spawn_world():
	var world_inst = world.instantiate()
	world_inst.global_position = Vector2(0,0)
	add_child(world_inst)
