extends Node2D

onready var end_label = $"CanvasLayer/Label End"
onready var end_type = $"CanvasLayer/Label Type"
onready var color_rect = $"CanvasLayer/ColorRect"
onready var spike = $EndSpikes


func _process(delta):
	var bodies = spike.get_overlapping_bodies();
	for body in bodies:
		if body.name == "Player" and not globals.finished:
			globals.can_move = false
			globals.can_shoot = false
			globals.can_duck = false
			globals.finished = true;
			body.get_node("AnimatedSprite").play("Idle");
			body.step_timer.set_paused(true);
			body.motion = Vector2.ZERO
			if globals.has_cake == true:
				end_label.text = "The End!"
				end_type.text = "You got: Good Ending!"
			else:
				spike.get_node("AnimationPlayer").play("Fall")
				yield(spike.get_node("AnimationPlayer"), "animation_finished")
				spike.get_node("AnimationPlayer").stop()
				body.visible = not visible
				spike.visible = not visible
				color_rect.queue_free()
				end_label.text = "The End!"
				end_type.text = "You got: Bad Ending!"
			ScreenText.get_node("PowerUpText").text = "Thanks for Playing! Press enter to return to menu!";
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_pause"):
		globals._reset_globals();
		ScreenText.get_node("PowerUpText").text = "";
		get_tree().change_scene("res://SCENES/Menu.tscn");