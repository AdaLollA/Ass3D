@tool
extends CharacterBody3D

# 0  player faction
# >0 enemies
# <0 allies
@export var faction: int:
	set(v):
		faction = v
		# update mesh to represent faction
		update_faction()
var body

const SPEED = 5.0
const JUMP_FORCE = 4.5

var selected = false

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	update_faction()
	$Weapon.fire()

func _physics_process(delta):
	if not Engine.is_editor_hint() and faction == 0:
		# Add the gravity.
		if not is_on_floor():
			motion_velocity.y -= gravity * delta

		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			motion_velocity.y = JUMP_FORCE

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			motion_velocity.x = direction.x * SPEED
			motion_velocity.z = direction.z * SPEED
		else:
			motion_velocity.x = move_toward(motion_velocity.x, 0, SPEED)
			motion_velocity.z = move_toward(motion_velocity.z, 0, SPEED)

		move_and_slide()

func _on_pawn_input_event(camera, event, position, normal, shape_idx):
	if not Engine.is_editor_hint() and faction == 0:
		if event is InputEventMouseButton:
			if event.pressed:
				handle_selection()

func handle_selection():
	selected = !selected
	if selected:
		body.mesh.surface_get_material(0).emission_enabled = true
	else:
		body.mesh.surface_get_material(0).emission_enabled = false

func update_faction():
	if $BodyPlayer and $BodyEnemy:
		if faction == 0:
			body = $BodyPlayer
			body.visible = true
			$BodyEnemy.visible = false
		elif faction > 0:
			body = $BodyEnemy
			body.visible = true
			$BodyPlayer.visible = false
