extends Area2D

#onready var screen_text = get_node("/root/ScreenText");
var powerup_scene = preload("res://Props/DjOrb.tscn");
var is_open: bool = false;

func _physics_process(delta):
	var bodies = get_overlapping_bodies();
	for body in bodies:
		if body.name == "Player":
			if(Input.is_action_just_pressed("ui_action") && !is_open):
				is_open = true;
				ScreenText.get_node("PowerUpText")._change_text("You just opened the Chest!");
				$ChestClosed.visible = false;
				$ChestOpen.visible = true;
				var powerup = powerup_scene.instance();
				powerup.position = Vector2(-1, -30);
				add_child(powerup);