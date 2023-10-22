extends State

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func enter():
	print("Player State - Idle")
	#owner.get_node("AnimationPlayer").play("idle")


func handle_input(event: InputEvent):
	# Add input handling for actions that aren't covered explicitly in update()
	#if event.is_action_pressed("simulate_damage"):
	#	emit_signal("finished", "stagger")
	pass


func update(_delta: float):
	# Gravity still exists, even when the Player isn't moving. Make sure they 
	#   end up / stay on the the ground.
	if not owner.is_on_floor():
		owner.velocity.y -= gravity * _delta
		owner.move_and_slide()
	
	# I guess Vector2(0,0) counts as False?
	if Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	):
		emit_signal("finished", "move")

