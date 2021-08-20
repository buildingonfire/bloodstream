extends Node2D

export(float) var growth_factor = 0
export(float) var minimum_size = 0.25
export(float) var maximum_size = 2.25
export(Color) var color_a = Color(1, 1, 1)
export(Color) var color_b = Color(1, 0, 0)

enum{
	GROWING,
	SHRINKING,
	DEAD
	}

var prev_growth = growth_factor
var state = GROWING
var instability = 0.0

onready var collision : CollisionShape2D = $Area2D/Collision
onready var area : Area2D = $Area2D
onready var sprite : Sprite = $Sprite

func _process(_delta):
	check_dead()
	calculate_instability(scale.x)
	match state:
		GROWING:
			grow(growth_factor)
			growth_factor *= 1.01
			sprite.modulate = lerp(color_a, color_b, instability)
		SHRINKING:
			grow(-growth_factor)
		DEAD:
			growth_factor = 0
			queue_free()

func grow(amt):
	var amt2 : Vector2 = Vector2(amt, amt)
	scale += amt2
	prev_growth = amt

func _on_Area2D_body_entered(_body):
	state = SHRINKING

func check_dead():
	var main = get_tree().current_scene
	if main.is_in_group("World"):
		if scale.x < minimum_size:
			add_to_score()
			state = DEAD
		elif scale.x > maximum_size:
			state = DEAD
		else:
			pass

func calculate_instability(current_size):
		instability = remap_range(current_size, minimum_size, maximum_size, 0, 1)

func remap_range(value, InputA, InputB, OutputA, OutputB):
	return(value - InputA) / (InputB - InputA) * (OutputB - OutputA) + OutputA

func add_to_score():
	var main = get_tree().current_scene
	main.score += 1

func reduce_score():
	var main = get_tree().current_scene
	if main.is_in_group("World"):
		main.score -= 1
