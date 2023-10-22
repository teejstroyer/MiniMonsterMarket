extends Area3D

@export var playerNode: Node3D
@export var connectedScene: PackedScene

var isPlayerInside = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with funcion body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isPlayerInside:
		print(position.distance_to(playerNode.position),"   ",(position.distance_to(playerNode.position)-1.5)/(2.5-1.5))
		playerNode.speed_modifier = (position.distance_to(playerNode.position)-1.5)/(2.5-1.5)
		if(position.distance_to(playerNode.position) <= 1.7):
			# https://ask.godotengine.org/141564/how-from-scene-scene-and-then-back-scene-right-where-left-off
			get_tree().change_scene_to_packed(connectedScene)
			


func _on_body_entered(body):
	print(body.name," entered the area ",name)
	isPlayerInside = body == playerNode


func _on_body_exited(body):
	print(body.name," exited the area ",name)
	isPlayerInside = false


