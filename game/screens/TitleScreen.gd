extends Control

export(String, FILE, '*.tscn') var start_scene

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$UI/Buttons/Start.grab_focus()


func _on_Start_click(__):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	yield(get_tree(), "idle_frame")
	Trans.change_scene(start_scene)


func _on_Quit_click(__):
	get_tree().quit()
