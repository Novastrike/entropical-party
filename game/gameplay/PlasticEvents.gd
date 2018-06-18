extends Node2D

onready var anims = $AnimationPlayer.get_animation_list()


func play_random():
	$AnimationPlayer.play(anims[randi()%anims.size()])
