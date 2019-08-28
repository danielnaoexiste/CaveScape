extends Area2D

onready var screen_text = get_node("/root/ScreenText");

func _physics_process(delta):
	var bodies = get_overlapping_bodies();
	for body in bodies:
		if body.name == "Player":
			ScreenText.get_node("PowerUpText")._change_text("You Just Got: ");
			body.get_node("Sounds").get_node("PowerUpSound").set_pitch_scale(rand_range(0.8, 1));
			body.get_node("Sounds").get_node("PowerUpSound").play();
			globals.keys += 1;
			print("Keys: " + globals.keys as String);
			self.queue_free();