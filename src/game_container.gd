extends Node2D
class_name GameContainer

@onready var audio_player : Object = $AudioStreamPlayer

@onready var main_menu : PackedScene = preload("res://src/ui/main_menu.tscn")
@onready var world : PackedScene = preload("res://src/levels/world.tscn")
@onready var gameover_screen : PackedScene = preload("res://src/ui/game_over_ui.tscn")

@onready var world_inst : Object = null

func _ready():
	spawn_main_menu()
	audio_player.play()
	#spawn_world()

func spawn_main_menu():
	var main_menu_inst = main_menu.instantiate()
	main_menu_inst.global_position = Vector2(0,0)
	add_child(main_menu_inst)

func spawn_world():
	world_inst = world.instantiate()
	world_inst.global_position = Vector2(0,0)
	add_child(world_inst)

func spawn_gameover():
	var gameover_inst = gameover_screen.instantiate()
	add_child(gameover_inst)
