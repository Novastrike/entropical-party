extends AudioStreamPlayer2D

export(float) var cooldown = 15.0
var can_speak = true
onready var lines = $Lines.get_animation_list()

func _ready():
	$Timer.wait_time = cooldown

func hono():
	$OhNo.play('not-feeling-so-hot')
	yield($OhNo, 'animation_finished')

func random_line():
	if can_speak:
		can_speak = false
		$Lines.play(lines[randi()%lines.size()])
		$Timer.start()

func _on_Timer_timeout():
	can_speak = true
