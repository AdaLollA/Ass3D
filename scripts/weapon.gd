extends Node3D

const PROJECTILE = preload("res://scenes/projectile.tscn")

@export var damage := 1
@export var muzzle_velocity := 10
@export var burst_size := 3
@export var shot_cooldown := 0.2
@export var burst_cooldown := 3

var burst: int = burst_size
var target = null:
	set(v):
		target = v
		fire()

func _ready():
	$ShotCooldown.wait_time = shot_cooldown
	$BurstCooldown.wait_time = burst_cooldown

func fire():
	# prepare
	var projectile = PROJECTILE.instantiate()
	projectile.position = $MuzzleExit.global_transform.origin
	projectile.apply_central_impulse((target - global_transform.origin).normalized() * muzzle_velocity)
	projectile.damage = damage
	#projectile.rotation = get_parent().global_transform.basis.get_euler()
	#projectile.transform.rotated(Vector3(1, 0, 0), PI)
	#projectile.global_transform.basis = global_transform.basis
	
	# add node
	var projectile_container = get_tree().root.get_child(0).get_node('Projectiles')
	projectile_container.add_child(projectile)
	projectile.look_at(target, Vector3.UP)
	
	# flash
	$Flash.visible = true
	$Flash/FlashDuration.start()
	
	# handle burst
	burst -= 1
	if burst > 0:
		# still shots left
		$ShotCooldown.start()
	else:
		$BurstCooldown.start()

func _on_flash_duration_timeout():
	$Flash.visible = false

func _on_shot_cooldown_timeout():
	fire()

func _on_burst_cooldown_timeout():
	burst = burst_size
	if target != null:
		fire()
