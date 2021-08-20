extends Timer

func _on_LevelTimer_timeout():
	wait_time -= .02
	var main = get_tree().current_scene
	if main.is_in_group("World"):
		main.set_infection_rate(1.0 - wait_time)
