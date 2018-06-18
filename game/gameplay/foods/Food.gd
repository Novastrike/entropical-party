extends RigidBody2D

enum { FREEZING, COOKING, BURNT }
signal gone

const MAX_Y = 1000.0
var heat_transfer = 1.0
var temperature = 0.0
var state = FREEZING

func _enter_tree():
	$Cook.connect('area_entered', self, 'on_Cook_area_entered')
	$Cook.connect('area_exited', self, 'on_Cook_area_exited')

func _ready():
	angular_velocity = 5
	angular_damp = 0.1

func _process(delta):
	if position.y > MAX_Y:
		gone()
	else:
		var temp = delta*heat_transfer
		if state == FREEZING:
			temperature = max(temperature-(temp*2), 0)
		elif state == COOKING:
			temperature += temp
		_food_process(delta)

func _food_process(delta):
	pass

func burnt():
	state = BURNT
	state_change(state)

func cook_start():
	state = COOKING
	state_change(state)

func cook_stop():
	state = FREEZING
	state_change(state)

func get_points():
	if state == BURNT:
		return 0

func gone():
	emit_signal('gone')
	queue_free()

func state_change(state):
	pass

func on_Cook_area_entered(area):
	if state != BURNT:
		if area.is_in_group('warm'):
			cook_start()
		elif area.is_in_group('sun'):
			burnt()

func on_Cook_area_exited(area):
	if state != BURNT:
		if area.is_in_group('warm'):
			cook_stop()
