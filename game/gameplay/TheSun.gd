tool
extends Area2D

export(bool) var can_move = true
export(float) var max_speed = 300.0
export(float) var acceleration = 12.0
export(float) var warm_radius = 400

const NO_MOVE = Vector2()
const LIMITS = Rect2(0, 0, 1600, 900)
var current_speed = Vector2(0,0)


func _ready():
	$Warm/CollisionShape2D.shape.radius = warm_radius

func _physics_process(delta):
	if can_move:
		_process_move(delta)

func _process_move(delta):
	var movement = NO_MOVE
	if Input.get_action_strength('sun_up'):
		movement.y = -Input.get_action_strength('sun_up')
	elif Input.get_action_strength('sun_down'):
		movement.y = Input.get_action_strength('sun_down')
	if Input.get_action_strength('sun_left'):
		movement.x = -Input.get_action_strength('sun_left')
	elif Input.get_action_strength('sun_right'):
		movement.x = Input.get_action_strength('sun_right')
	if movement != NO_MOVE:
		current_speed += movement*acceleration
		current_speed = current_speed.clamped(max_speed)
	translate(current_speed*delta)
	if not int(position.x) in range(LIMITS.position.x, LIMITS.size.x):
		current_speed.x*=-1
		position.x = clamp(position.x, LIMITS.position.x, LIMITS.size.x)
	if not int(position.y) in range(LIMITS.position.y, LIMITS.size.y):
		current_speed.y*=-1
		position.y = clamp(position.y, LIMITS.position.y, LIMITS.size.y)

func _draw():
	if OS.is_debug_build():
		draw_circle(Vector2(), warm_radius, Color(1, 0, 0, 0.1))

func random_line():
	$NotBubsy.random_line()
