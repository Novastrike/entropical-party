extends Node2D

onready var anims = $AnimationPlayer.get_animation_list()

func _ready():
	$PlasticSun.set_collisions(false)

func play_random():
	$AnimationPlayer.play(anims[randi()%anims.size()])
