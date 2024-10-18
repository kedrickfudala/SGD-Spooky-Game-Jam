extends Control
class_name MainMenu


func _on_play_button_pressed() -> void:
	get_parent().spawn_world()
	queue_free()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
