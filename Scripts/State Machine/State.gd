extends Node
class_name State
# Base "interface" for states
# State machine heavily based on Godot demo project
# https://github.com/godotengine/godot-demo-projects/tree/3.5-9e68af3/2d/finite_state_machine


signal finished(next_state_name: String)


# Initialize state
func enter():
	pass


# Clean up and dispose of data
func exit():
	pass


func handle_input(_event: InputEvent):
	pass


func update(_delta: float):
	pass


func _on_animation_finished(_anim_name: String):
	pass

