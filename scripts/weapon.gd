extends Node3D

class_name Weapon

const PROJECTILE = preload("res://scenes/projectile.tscn")

@export var muzzle_velocity := 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fire():
	# prepare
	var projectile = PROJECTILE.instantiate()
	projectile.position = $MuzzleExit.global_transform.origin
	projectile.apply_central_impulse(Vector3(muzzle_velocity, 0, 0))
	
	# add node
	var projectile_container = get_tree().root.get_child(0).get_node('Projectiles')
	projectile_container.add_child(projectile)
	
	# flash
	$Flash.visible = true
	$Flash/FlashDuration.start()

func _on_flash_duration_timeout():
	$Flash.visible = false
