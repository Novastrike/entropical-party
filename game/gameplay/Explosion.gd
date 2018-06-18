extends Sprite


func explode():
	$AnimationPlayer.play('explode')
	yield($AnimationPlayer, "animation_finished")