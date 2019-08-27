extends Area2D

onready var spawn_point = get_tree().get_root().get_node("World").get_node("Spawn Point");

func _physics_process(delta):
	var bodies = get_overlapping_bodies();
	for body in bodies:
		if body.name == "Player":
			body.is_alive = false;
			body.position = spawn_point.position;
			body.is_alive = true; 
