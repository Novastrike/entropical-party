extends Label


func update_score(score):
	text = '%06d' % score
	$AnimationPlayer.play('score-update')
