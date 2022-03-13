extends Node3D

const PROJECTILE = preload("res://scenes/projectile.tscn")

@export var muzzle_velocity := 10
@export var burst_size := 3
@export var shot_cooldown := 0.2
@export var burst_cooldown := 3

var burst: int = burst_size

func _ready():
	$ShotCooldown.wait_time = shot_cooldown
	$BurstCooldown.wait_time = burst_cooldown

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
	
	# handle burst
	burst -= 1
	if burst > 0:
		# still shots left
		$ShotCooldown.start()

func _on_flash_duration_timeout():
	$Flash.visible = false
