extends Area2D

onready var screen_text = get_node("/root/ScreenText");
var powerup_scene = preload("res://Props/DjOrb.tscn");

func _physics_process(delta):
	var bodies = get_overlapping_bodies();
	for body in bodies:
		if body.name == "Player":
			if(Input.is_action_just_pressed("ui_action")):
				ScreenText.get_node("PowerUpText")._change_text("You just opened the Chest!");
				$ChestClosed.visible = false;
				$ChestOpen.visible = true;
			#	var powerup = powerup_scene.instance();
			#	get_tree.add_child(powerup);
