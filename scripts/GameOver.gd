extends Node2D

onready var scoreLabel = $CenterContainer/VBoxContainer/ScoreLabel

func set_score(val):
	scoreLabel.text = String(val)
