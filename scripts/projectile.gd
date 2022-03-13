extends RigidDynamicBody3D

var damage = 1

func _on_max_lifetime_timeout():
	queue_free()

func _on_projectile_body_entered(body):
	print('collision')
	print(body)
	queue_free()
	# todo: only remove when hitting environment, otherwise handle removal
