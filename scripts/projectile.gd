extends RigidDynamicBody3D

var damage = 1

func _on_max_lifetime_timeout():
	queue_free()

func _on_projectile_body_entered(body):
	# remove when hitting environment, otherwise handle removal
	if 'Map' == body.get_parent().name:
		queue_free()
	elif 'Pawn' == body.name:
		queue_free()
		print('deal damage') # todo
