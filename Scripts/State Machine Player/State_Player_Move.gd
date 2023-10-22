extends State

# I figured I'd make a reference to save the constant function calls in update()
@onready var parent = get_parent()
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func enter():
	print("Player state - Move")
	var input_direction = get_input_direction()
	update_look_direction(input_direction)


func handle_input(event: InputEvent):
	return super.handle_input(event)


func update(_delta: float):
	var input_direction = get_input_direction()
	if not input_direction:
		emit_signal("finished", "idle")
	update_look_direction(input_direction)
	
	# Add the gravity.
	if not owner.is_on_floor():
		owner.velocity.y -= gravity * _delta

	var direction = (owner.transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	if direction:
		owner.velocity.x = direction.x * parent.movement_speed_base * parent.movement_speed_modifier
		owner.velocity.z = direction.z * parent.movement_speed_base * parent.movement_speed_modifier
	else:
		owner.velocity.x = move_toward(owner.velocity.x, 0, parent.movement_speed_base * parent.movement_speed_modifier)
		owner.velocity.z = move_toward(owner.velocity.z, 0, parent.movement_speed_base * parent.movement_speed_modifier)
	
	owner.move_and_slide()
	if owner.get_slide_collision_count() != 0:
		pass
	


func get_input_direction():
	return Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)


func update_look_direction(direction: Vector2):
	if direction and parent.look_direction != direction:
		parent.look_direction = direction
		var weapon = owner.find_child("Weapon")
		if weapon != null && direction.x != 0:
			weapon.scale.x = direction.x
	

