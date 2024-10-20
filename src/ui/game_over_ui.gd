extends CanvasLayer

@onready var game_container = get_parent()

func _on_button_pressed() -> void:
	print("hahaha")
	game_container.world_inst.queue_free()
	game_container.spawn_world()
	queue_free()
