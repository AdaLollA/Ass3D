extends Camera3D

const DRAG_SPEED = 0.01

var dragging = false
var previous_drag = null

func _input(event):
	if event is InputEventMouseButton:
		dragging = event.pressed
		previous_drag = event.position
	elif event is InputEventMouseMotion:
		if dragging:
			position.x += (previous_drag.x - event.position.x) * DRAG_SPEED
			position.z += (previous_drag.y - event.position.y) * DRAG_SPEED
			previous_drag = event.position

