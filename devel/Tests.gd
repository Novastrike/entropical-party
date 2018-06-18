extends Node2D

var score = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Score.update_score(score)


func _on_UFO_add_score(points):
	score += points
	$Score.update_score(score)
