extends StaticBody2D
class_name ComboObject

@onready var sprite : Object = $Sprite2D

@export var score_value : int
@export var time_value : float

func _ready():
	modulate_green()

func modulate_green():
	var modulate_tween1 = create_tween()
	modulate_tween1.tween_property(sprite, "modulate", Color(0,1,0), 0.5)
	await modulate_tween1.finished
	modulate_white()
	
func modulate_white():
	var modulate_tween2 = create_tween()
	modulate_tween2.tween_property(sprite, "modulate", Color(1,1,1), 0.5)
	await modulate_tween2.finished
	modulate_green()
