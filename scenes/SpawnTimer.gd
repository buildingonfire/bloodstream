extends Timer

func _on_LevelTimer_timeout():
	wait_time -= .02
	print(wait_time)
