extends KinematicBody2D

export var move_speed : float = 500.0

var state : int = MOVE_YES

enum{
	MOVE_YES,
	MOVE_NO	
}

func _process(_delta):
	match state:
		MOVE_YES:
			move_speed = 500
			_look_at_mouse()
			_move_to_mouse()
		MOVE_NO:
			move_speed = 0


func _look_at_mouse():
	look_at(get_global_mouse_position())


func _move_to_mouse():
	var direction = get_global_mouse_position() - position
	move_and_slide(direction.normalized() * move_speed)


func _on_MovementPad_mouse_exited():
	state = MOVE_YES
	print("Move YES")

	
func _on_MovementPad_mouse_entered():
	state = MOVE_NO
	print("Move NO")
