extends Control

onready var step_timer = $"Walk Audio/TimerStep";
onready var stop_timer = $"Walk Audio/TimerStop";

onready var hit_timer = $"Hit Audio/Timer";

func _ready():
	$AnimatedSprite.play("default");
	step_timer.start(0.33);
	stop_timer.start(1);

func _on_AnimatedSprite_animation_finished():
	$"/root/ScreenText".get_node("PowerUpText").text = "Thanks for Playing! Return to Menu!";
	
func _physics_process(delta):
	if(Input.is_action_just_pressed("ui_accept")):
		get_tree().change_scene("res://SCENES/Menu.tscn");

func _on_TimerStep_timeout():
	$"Walk Audio".set_pitch_scale(rand_range(0.5, 1));
	$"Walk Audio".play();


func _on_TimerStop_timeout():
	step_timer.set_paused(true);


func _on_Timer_timeout():
	$"Hit Audio".play();
