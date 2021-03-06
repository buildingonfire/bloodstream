extends Node2D

const Enemy = preload("res://scenes/enemy.tscn")

onready var spawnPoints = $SpawnPoints

func _ready():
	randomize()

func get_spawn_position():
	var points = spawnPoints.get_children()
	points.shuffle()
	return points[0].global_position

func spawn_enemy():
	var spawn_location = get_spawn_position()
	var enemy = Enemy.instance()
	#var main = get_tree().current_scene
	self.add_child(enemy)
	enemy.global_position = spawn_location
	enemy.rotation = rand_range(-180.0, 180.0)
	enemy.z_index = randi() % 4

func _on_SpawnTimer_timeout():
	spawn_enemy()
