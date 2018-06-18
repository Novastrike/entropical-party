extends Node2D

signal score_update(score)

export(float) var debug_score = 0
const GAMEOVER = 'res://game/screens/GameOverScreen.tscn'
var score = 0
var lives = 5
var can_pause = true
onready var spawn_area = $SpawnArea

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if OS.is_debug_build():
		add_score(debug_score)
	else:
		add_score(0) # HAXX

func _input(event):
	if event.is_action_pressed('pause') and can_pause:
		get_tree().paused = not get_tree().paused
		$Pause.visible = get_tree().paused

func game_over():
	yield($TheSun/NotBubsy.hono(), 'completed')
	Score.update_highscore(score)
	Trans.change_scene(GAMEOVER)

func add_score(points):
	score += points
	$Score.update_score(score)
	emit_signal('score_update', score)
	if points > 1:
		$TheSun.random_line()

func _on_UFO_add_score(points):
	add_score(points)

func _on_UFO_dead():
	can_pause = false
	$TheSun.can_move = false

func _on_UFO_explode():
	game_over()

func _on_SpawnEvents_spawn_at(food, at):
	food.connect('gone', self, '_on_Food_gone')
	spawn_area.add_child(food)
	food.position = at

func _on_SpawnEvents_plastic_sun():
	$PlasticEvents.play_random()

func _on_Food_gone():
	lives -= 1
	$Lives.text = 'Lives %s' % max(lives, 0)
	if lives == 0:
		$UFO.explode()
