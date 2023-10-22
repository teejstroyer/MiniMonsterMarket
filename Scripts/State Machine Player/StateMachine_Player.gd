extends StateMachine

@onready var attack = $Attack

var insanity = 0
var movement_speed_modifier = 1
var movement_speed_base = 5
var is_in_portal = false
var look_direction = Vector2.RIGHT


func _ready():
	states_map = {
		"idle": $Idle,
		"move": $Move,
		"attack": attack
	}
	# Make sure we start up the SM as well
	super._ready()


func _change_state(state_name: String):
	# Do Player-specific reactions and state overrides here, the base class
	#   will handle the rest.
	if state_name == "attack":
		states_stack.push_front(states_map[state_name])
	
	super._change_state(state_name)


func _unhandled_input(event: InputEvent):
	# This lets us handle inputs which could interrupt states, like attacking
	# Otherwise, the nodes handle themselves
	if event.is_action_pressed("action") && current_state != attack:
		_change_state("attack")
	else:
		current_state.handle_input(event)

