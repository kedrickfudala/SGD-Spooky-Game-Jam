extends Node2D
class_name LevelTemplate

@onready var world = get_parent()

@export var right_height : int

func _physics_process(delta: float) -> void:
	if world.game_start:
		global_position.x -= world.speed
		if world.player_inst:
			if global_position.x <= world.player_inst.global_position.x - 512:
				world.spawn_random_level(global_position.x + (512 * 3))
				queue_free()
		else:
			print("ERROR: Player inst does not exist")
