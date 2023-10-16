extends Area3D

@export var playerNode:Node3D

var isPlayerInside = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isPlayerInside:
		print(position.distance_to(playerNode.position))
		playerNode.speed_modifier = (position.distance_to(playerNode.position)-0.5)/(1.5-0.5)
		if(position.distance_to(playerNode.position) <= 0.6):
			print("nav to nether realm")
	#print(playerNode.speed_modifier)

func _on_body_entered(body):
	print(body.name," entered the area ",name)
	isPlayerInside = body == playerNode


func _on_body_exited(body):
	print(body.name," exited the area ",name)
	isPlayerInside = false


