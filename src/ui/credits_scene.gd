extends Control

@onready var game_container = get_parent()

func _on_back_button_pressed() -> void:
	game_container.spawn_main_menu()
	queue_free()
