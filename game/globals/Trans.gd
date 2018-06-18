extends CanvasLayer

export(float) var change_scene_keyframe = 0.5
var next_scene
var changing_scene = false


func _process(delta):
	if changing_scene:
		if $AnimationPlayer.current_animation_position >= change_scene_keyframe:
			changing_scene = false
			load_next_scene()

func change_scene(to):
	next_scene = load(to)
	changing_scene = true
	$AnimationPlayer.play('Transition')

func load_next_scene():
	get_tree().change_scene_to(next_scene)
