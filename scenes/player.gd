extends KinematicBody2D

func _process(_delta):
	_look_at_mouse()
	_move_to_mouse()
	
func _look_at_mouse():
	look_at(get_global_mouse_position())

func _move_to_mouse():
	var direction = get_global_mouse_position() - position
	move_and_slide(direction)
