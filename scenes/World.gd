extends Node

var score : int = 0 setget set_score

onready var scoreLabel = $ScoreLabel

#score logic
func set_score(value):
	score = value
	update_score_label(score)

func update_score_label(score):
	scoreLabel.text = "Score = " + String(score)

func _ready():
	set_score(score)
