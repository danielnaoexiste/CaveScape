extends Control

onready var screen_text = get_node("/root/ScreenText");
onready var play_button = $MarginContainer/Buttons/Play
onready var quit_button = $MarginContainer/Buttons/Quit

func _ready():
	globals._reset_globals()
	play_button.grab_focus();
	ScreenText.get_node("PowerUpText").text = "by: Daniel Gazzaneo (@VulponDEV)";


func _process(delta):
	if(play_button.is_hovered()):
		play_button.grab_focus();
	if(quit_button.is_hovered()):
		quit_button.grab_focus();

func _on_Play_pressed():
	ScreenText.get_node("PowerUpText").text = "";
	get_tree().change_scene("res://SCENES/World.tscn");

func _on_Quit_pressed():
	get_tree().quit();
