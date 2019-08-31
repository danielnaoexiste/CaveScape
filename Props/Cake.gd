extends Area2D

onready var screen_text = get_node("/root/ScreenText");

func _physics_process(delta):
	var bodies = get_overlapping_bodies();
	for body in bodies:
		if body.name == "Player":
			body.get_node("Sounds").get_node("PowerUpSound").set_pitch_scale(rand_range(0.8, 1));
			body.get_node("Sounds").get_node("PowerUpSound").play();
			ScreenText.get_node("PowerUpText")._change_text("You Just Got: The Real Cake");
			if (globals.n_chest == 4):
				globals.has_cake = true;
				globals.n_chest += 1;
			self.queue_free();