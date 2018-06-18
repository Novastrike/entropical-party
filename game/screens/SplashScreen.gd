extends Control

export(String, FILE, '*.tscn') var next_scene

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_animation_finished(__):
	Trans.change_scene(next_scene)
