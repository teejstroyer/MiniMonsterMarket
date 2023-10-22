extends Node3D

@export var monster_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = RandomNumberGenerator.new()
	for i in range(0,3,1):
		var monster = monster_scene.instantiate()
		monster.set_collision_layer(3)	
		add_child(monster)
		var radius = 5.0 * sqrt(rand.randf())
		var theta = rand.randf() * 2.0 * PI
		# Position will be relative to spawner node
		monster.position = Vector3((radius*sin(theta)), 0.5, (radius*cos(theta)))
		if position.distance_to(Vector3(0,0,0)) > 5:
			monster.health = 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
