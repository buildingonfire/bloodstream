extends Node

var score : int = 0 setget set_score
var infection_rate : float = 0.0 setget set_infection_rate

const GameOverMessage = preload("res://scenes/GameOver.tscn")

onready var player = $player
onready var scoreLabel = $ScoreLabel
onready var rateLabel = $InfectionRateLabel
onready var enemySpawner = $EnemySpawner
onready var spawnTimer = $EnemySpawner/SpawnTimer

#score logic
func set_score(value):
	score = value
	update_score_label()

func set_infection_rate(value):
	infection_rate = value
	update_rate_label(infection_rate)

func update_score_label():
	scoreLabel.text = "Score = " + String(score)
	
func update_rate_label(rate):
	rateLabel.text = "Infection Rate = " + String(rate)

func _ready():
	set_score(score)
	set_infection_rate(0.1)

func _on_GameTimer_timeout():
	end_game()
	
func end_game():
	spawnTimer.queue_free()
	yield(get_tree().create_timer(4.2), "timeout")
	player.queue_free()
	scoreLabel.queue_free()
	rateLabel.queue_free()
	var gameOver = GameOverMessage.instance()
	var main = get_tree().current_scene
	main.add_child(gameOver)
	gameOver.set_score(score)
