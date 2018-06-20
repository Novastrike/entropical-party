extends KinematicBody2D

signal dead
signal explode
signal add_score

export(float) var max_speed = 400.0
export(float) var acceleration = 12.0
const NO_MOVE = Vector2()
const LIMITS = Rect2(0, 0, 1600, 900)

var current_speed = Vector2(0,0)
var can_move = true
var dead = false

func _ready():
	pass

func _physics_process(delta):
	if can_move:
		process_move(delta)

func process_move(delta):
	var movement = NO_MOVE
	if Input.get_action_strength('ufo_up'):
		movement.y = -Input.get_action_strength('ufo_up')
	elif Input.get_action_strength('ufo_down'):
		movement.y = Input.get_action_strength('ufo_down')
	if Input.get_action_strength('ufo_left'):
		movement.x = -Input.get_action_strength('ufo_left')
	elif Input.get_action_strength('ufo_right'):
		movement.x = Input.get_action_strength('ufo_right')
	if movement != NO_MOVE:
		current_speed+=movement*acceleration
		current_speed = current_speed.clamped(max_speed)
	move_and_collide(current_speed*delta)
	if not int(position.x) in range(LIMITS.position.x, LIMITS.size.x):
		current_speed.x*=-1
		position.x = clamp(position.x, LIMITS.position.x, LIMITS.size.x)
	if not int(position.y) in range(LIMITS.position.y, LIMITS.size.y):
		current_speed.y*=-1
		position.y = clamp(position.y, LIMITS.position.y, LIMITS.size.y)

func explode():
	if not dead:
		emit_signal('dead')
		dead = true
		can_move = false
		$Sprite.hide()
		$ActionLines.play()
		yield($Explosion.explode(), 'completed')
		emit_signal('explode')

func food_catch(food):
	$CatchFood.play()
	var points = food.get_points()
	if points:
		emit_signal('add_score', points)
	food.queue_free()

func _on_HitBox_area_entered(area):
	if not dead and area.is_in_group('sun'):
		explode()

func _on_FoodBox_body_entered(body):
	if not dead and body.is_in_group('food'):
		food_catch(body)
