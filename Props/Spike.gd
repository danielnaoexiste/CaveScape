extends Area2D

onready var spawn_point = get_tree().get_root().get_node("World").get_node("Spawn Point");

func _physics_process(delta):
	var bodies = get_overlapping_bodies();
	for body in bodies:
		if body.name == "Player":
			body.is_alive = false;
			body.get_node("Camera2D").get_node("ScreenShake")._start(0.3, 15, 5, 1);
			body.motion = Vector2(0, 0);
			body.position = spawn_point.position;
			body.get_node("Sounds").get_node("HitSound").set_pitch_scale(rand_range(0.7, 1))
			body.get_node("Sounds").get_node("HitSound").play();
			body.is_alive = true; 
