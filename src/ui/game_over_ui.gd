extends CanvasLayer

@onready var game_container = get_parent()

func _on_restart_button_pressed() -> void:
	game_container.world_inst.queue_free()
	game_container.spawn_world()
	queue_free()

func _on_main_menu_button_pressed() -> void:
	game_container.world_inst.queue_free()
	game_container.spawn_main_menu()
	queue_free()
