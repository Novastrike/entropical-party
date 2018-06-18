tool
extends TextureButton

signal click(button)

export(String, 'Start', 'Retry', 'Ok', 'Quit') var button setget set_button
export(bool) var one_click = true
var pressing = false

func set_button(b):
	button = b
	if button:
		call_deferred('update_button')

func update_button():
	$AnimationPlayer.play(button)


func _on_pressed():
	if not pressing:
		pressing = true
		prints(button, 'clicked')
		$AnimationPlayer.play('Click')
		yield($AnimationPlayer, "animation_finished")
		update_button()
		yield($Click, "finished")
		emit_signal('click', button)
		if not one_click:
			pressing = false


func _on_focus_entered():
	$AnimationPlayer.play('Focus')
	yield($AnimationPlayer, "animation_finished")
	update_button()
