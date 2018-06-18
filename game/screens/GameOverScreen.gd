extends Control

const TITLE_SCREEN = 'res://game/screens/TitleScreen.tscn'
const NEW_GAME = 'res://game/screens/GameScreen.tscn'

func _ready():
	show_score(Score.last_score, Score.best_score)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Buttons/Retry.grab_focus()

func show_score(score, best):
	$Score.text = '%06d' % score
	$Best.text = 'Best %06d' % best

func change_to(scene):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	yield(get_tree(), 'idle_frame')
	Trans.change_scene(scene)


func _on_Retry_click(__):
	change_to(NEW_GAME)

func _on_Quit_click(__):
	change_to(TITLE_SCREEN)
