extends './Food.gd'

enum { RAW, RARE, DONE }

export(float) var rare_temp = 2.0
export(float) var done_temp = 4.0
var cook_state = RAW
var points = { RAW: 1, RARE: 40, DONE: 0 }



func _food_process(delta):
	if temperature > rare_temp and cook_state == RAW:
		cook_state = RARE
		$AnimationPlayer.play('cooking')
	elif temperature > done_temp and cook_state != DONE:
		cook_state = DONE
		burnt()

func get_points():
	if state == BURNT:
		return 0
	return points[cook_state]

func state_change(state):
	$Cooking.emitting = state == COOKING
	$Frying.playing = state == COOKING
	if state == BURNT:
		$AnimationPlayer.play('burnt')
		yield($AnimationPlayer, "animation_finished")
		gone()

