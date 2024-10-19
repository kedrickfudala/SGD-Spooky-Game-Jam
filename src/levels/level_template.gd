extends Node2D
class_name LevelTemplate

@onready var level_position : int

@export var left_height : int
@export var right_height : int

func _on_right_area_area_entered(area: Area2D) -> void:
	get_parent().spawn_random_level()
	queue_free()
