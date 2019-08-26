extends Area2D

onready var screen_text = get_node("/root/ScreenText");

func _physics_process(delta):
	var bodies = get_overlapping_bodies();
	for body in bodies:
		if body.name == "Player":
			ScreenText.get_node("PowerUpText")._change_text("You Just Got: Double Jump!");
			body.get_node("PowerUpSound").play();
			body.MAX_JUMP_COUNT += 1;
			self.queue_free();