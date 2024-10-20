extends ComboObject

@onready var anim_player : Object = $AnimationPlayer

func _physics_process(_delta: float) -> void:
	anim_player.play("hand_anim")
