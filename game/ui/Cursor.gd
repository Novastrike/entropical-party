extends Node2D

export(bool) var use_global = true

func _process(delta):
	if use_global:
		global_position = get_global_mouse_position()
	else:
		position = get_local_mouse_position()
