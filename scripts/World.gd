extends Node

var score : int = 0 setget set_score
var infection_rate : float = 0.0 setget set_infection_rate

onready var scoreLabel = $ScoreLabel
onready var rateLabel = $InfectionRateLabel
onready var enemySpawner = $EnemySpawner

#score logic
func set_score(value):
	score = value
	update_score_label(score)

func set_infection_rate(value):
	infection_rate = value
	update_rate_label(infection_rate)

func update_score_label(score):
	scoreLabel.text = "Score = " + String(score)
	
func update_rate_label(rate):
	rateLabel.text = "Infection Rate = " + String(rate)

func _ready():
	set_score(score)
	set_infection_rate(0.1)

func _on_GameTimer_timeout():
	end_game(score)
	
func end_game(score):
	enemySpawner.queue_free()
	yield(get_tree().create_timer(3.2), "timeout")
	print("Game over! Your score: ", score)
	get_tree().change_scene("res://scenes/GameOver.tscn")
