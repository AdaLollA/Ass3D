extends RigidDynamicBody3D

func _on_max_lifetime_timeout():
	queue_free()
