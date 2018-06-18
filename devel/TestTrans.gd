extends Sprite

export(String, FILE, '*.tscn') var scene

func _ready():
	yield(get_tree().create_timer(5.0), "timeout")
	Trans.change_scene(scene)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
