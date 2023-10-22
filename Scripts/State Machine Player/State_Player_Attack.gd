extends State

@onready var weapon = owner.find_child("Weapon")

func enter():
	if weapon == null:
		emit_signal("finished", "previous")
	else:
		# Once completed, this would actually play the animation and react to
		#   the hitboxes in there, but until then, this will have to do for
		#   testing purposes
		weapon.visible = true
		weapon.find_child("Area3D").connect("body_entered", Callable(self, "_on_body_entered"))
		var timer = get_tree().create_timer(3.0)
		timer.connect("timeout",Callable(self, "attack_finished"))
		emit_signal("finished", "previous")
	


func attack_finished():
	if weapon != null:
		weapon.visible = false
	


func _on_body_entered(body):
	print("attack sword hit something ",body.name,"  ",body.collision_layer)
	if(body.collision_layer == 3):
		body.health -= 1
		print(body.health)
