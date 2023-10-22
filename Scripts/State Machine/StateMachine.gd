extends Node
class_name StateMachine

signal state_changed(current_state)

# You should set a starting node from the inspector or on the node that inherits
# from this state machine interface. If you don't, the game will default to
# the first state in the state machine's children.
@export var start_state: NodePath
# state name - node reference  key-value map
var states_map = {}
# Maintain a stack of state changes to make sure things all happen, and happen
#   in the correct order
var states_stack = []
var current_state = null


# Called when the node enters the scene tree for the first time.
func _ready():
	# If no starting state is assigned, get the first child Node of the SM node
	#   and use that for the default
	if not start_state:
		start_state = get_child(0).get_path()
	for child in get_children():
		var err = child.connect("finished", Callable(self, "_change_state"))
		if err:
			printerr(err)
	initialize(start_state)


func initialize(initial_state: NodePath):
	states_stack.push_front(get_node(initial_state))
	current_state = states_stack[0]
	current_state.enter()


func _unhandled_input(event: InputEvent):
	current_state.handle_input(event)


func _physics_process(delta: float):
	current_state.update(delta)


func _on_animation_finished(anim_name: String):
	current_state._on_animation_finished(anim_name)


func _change_state(state_name: String):
	current_state.exit()
	if state_name == "previous":
		states_stack.pop_front()
	else:
		states_stack[0] = states_map[state_name]
	current_state = states_stack[0]
	emit_signal("state_changed", current_state)
	if state_name != "previous":
		current_state.enter()
	

