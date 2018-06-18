extends './Food.gd'

enum { SOLID, MELTING1, MELTING2, MELTED }

export(float) var melting1_temp = 1.0
export(float) var melting2_temp = 2.0
export(float) var melted_temp = 3.0
var melting_state = SOLID
var points = { SOLID: 10, MELTING1: 5, MELTING1: 2, MELTED: 0 }



func _food_process(delta):
	if temperature > melting1_temp and melting_state == SOLID:
		melting_state = MELTING1
		$AnimationPlayer.play('melting1')
	elif temperature < melting1_temp and melting_state == MELTING1:
		melting_state = SOLID
		$AnimationPlayer.play('freezing')
	elif temperature > melting2_temp and melting_state == MELTING1:
		melting_state = MELTING2
		$AnimationPlayer.play('melting2')
	elif temperature < melting2_temp and melting_state == MELTING2:
		melting_state = MELTING1
		$AnimationPlayer.play('melting1')
	elif temperature > melted_temp and melting_state != MELTED:
		melting_state = MELTED
		burnt()

func get_points():
	if state == BURNT:
		return 0
	return points[melting_state]

func state_change(state):
	$Melting.emitting = state == COOKING
	if state == BURNT:
		$AnimationPlayer.play('melting-final')
		yield($AnimationPlayer, "animation_finished")
		gone()
