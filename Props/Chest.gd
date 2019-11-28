extends Area2D

#onready var screen_text = get_node("/root/ScreenText");
const powerup_scene = preload("res://Props/Orb.tscn");
const cake_scene = preload("res://Props/Cake.tscn");
onready var scr_text = get_node("/root/ScreenText");
var is_open: bool = false;

func _physics_process(delta):
	var bodies = get_overlapping_bodies();
	for body in bodies:
		if body.name == "Player":
			
			if position.distance_to(body.position) > 12 or is_open:
				$Arrow.visible = false;
			else:
				$Arrow.visible = true;
			
			if(Input.is_action_just_pressed("ui_action") && !is_open):
				if globals.n_chest < 4:
					if globals.keys > 0:
						is_open = true;
						globals.keys -= 1;
						print("Keys: " + globals.keys as String);
						ScreenText.get_node("PowerUpText")._change_text("You just opened the Chest!");
						$ChestClosed.visible = false;
						$ChestOpen.visible = true;
						$Arrow.visible = false;
						var powerup = powerup_scene.instance();
						powerup.position = Vector2(-1, -30);
						add_child(powerup);
					else:
						ScreenText.get_node("PowerUpText").text = "You need something to open this Chest";
						$TextTimer.start(2.5);
				else:
					if(Input.is_action_just_pressed("ui_action") && !is_open):
						if globals.keys > 0:
							is_open = true;
							globals.keys -= 1;
							ScreenText.get_node("PowerUpText")._change_text("You just opened the Chest!");
							$ChestClosed.visible = false;
							$ChestOpen.visible = true;
							$Arrow.visible = false;
							var cake = cake_scene.instance();
							cake.position = Vector2(-1, -30);
							add_child(cake);
						else:
							ScreenText.get_node("PowerUpText").text = "You need something to open this Chest";
							$TextTimer.start(2.5);
							
func _on_TextTimer_timeout():
	ScreenText.get_node("PowerUpText").text = "";
	$TextTimer.stop()
