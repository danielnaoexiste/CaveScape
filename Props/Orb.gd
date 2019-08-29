extends Area2D

onready var screen_text = get_node("/root/ScreenText");

func _physics_process(delta):
	var bodies = get_overlapping_bodies();
	for body in bodies:
		if body.name == "Player":
			ScreenText.get_node("PowerUpText")._change_text("You Just Got: ");
			body.get_node("Sounds").get_node("PowerUpSound").set_pitch_scale(rand_range(0.8, 1));
			body.get_node("Sounds").get_node("PowerUpSound").play();
			match globals.n_chest:
				0:
					globals.MAX_JUMP_COUNT += 1;
					print("DJ");
					globals.n_chest += 1;
				1:
					globals.can_wall_jump = true;
					print("WJ");
					globals.n_chest += 1;
				2:
					globals.can_duck = true;
					print("Duck")
					globals.n_chest += 1;
				3:
					globals.can_shoot = true;
					print("Gun");
					globals.n_chest += 1;
			self.queue_free();