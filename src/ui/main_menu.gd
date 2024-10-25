extends Control
class_name MainMenu

@onready var game_container = get_parent()

func _on_play_button_pressed() -> void:
	game_container.spawn_instructions()
	queue_free()

func _on_credits_button_pressed() -> void:
	game_container.spawn_credits()
	queue_free()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
