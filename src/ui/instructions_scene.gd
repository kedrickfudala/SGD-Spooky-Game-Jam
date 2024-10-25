extends Control

@onready var game_container = get_parent()

func _on_confirm_button_pressed() -> void:
	game_container.spawn_world()
	queue_free()
