extends Area2D

onready var screen_text = get_node("/root/ScreenText");

func _physics_process(delta):
	var bodies = get_overlapping_bodies();
	for body in bodies:
		if body.name == "Player":
			ScreenText.get_node("PowerUpText")._change_text("You Just Got: ");
			body.get_node("PowerUpSound").play();
			match body.n_chest:
				0:
					body.MAX_JUMP_COUNT += 1;
					print("DJ");
					body.n_chest += 1;
				1:
					body.can_wall_jump = true;
					print("WJ");
					body.n_chest += 1;
			self.queue_free();