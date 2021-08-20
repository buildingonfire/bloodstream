extends Node2D

export(float) var growth_factor = 0
export(float) var minimum_size = 0.25
export(float) var maximum_size = 2.25
export(Color) var color_a = Color(1, 1, 1)
export(Color) var color_b = Color(1, 0, 0)

enum{
	IDLE,
	GROWING,
	SHRINKING,
	DEAD
	}

var prev_growth = growth_factor
var growth_factor2 = Vector2(growth_factor, growth_factor)
var minimum_size2 = Vector2(minimum_size, minimum_size)
var maximum_size2 = Vector2(maximum_size, maximum_size)
var state = GROWING
var instability = 0.0

onready var collision : CollisionShape2D = $Area2D/Collision
onready var area : Area2D = $Area2D
onready var sprite : Sprite = $Sprite
onready var idleTimer : Timer = $Timer
onready var label : Label = $Label

func _process(_delta):
	check_dead()
	check_overlap()
	print("scale= ", scale.x)
	calculate_instability(scale.x)
	print("instability = ", instability)
	match state:
		IDLE:
			grow(-growth_factor/2)
		GROWING:
			grow(growth_factor)
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

func _on_Timer_timeout():
	print("shrink timer expire")
	state = GROWING
 
func _on_Area2D_body_exited(_body):
	state = SHRINKING
	idleTimer.start()

func check_overlap():
	if area.get_overlapping_bodies().empty() == false:
		state = SHRINKING
		growth_factor += 0.001

func check_dead():
	if scale < minimum_size2 || scale > maximum_size2 * 2 :
		state = DEAD

func calculate_instability(val):
		instability = remap_range(val, minimum_size, maximum_size, 0, 1)

func remap_range(value, InputA, InputB, OutputA, OutputB):
	return(value - InputA) / (InputB - InputA) * (OutputB - OutputA) + OutputA
