extends Control

onready var screen_text = get_node("/root/ScreenText");


func _ready():
	globals._reset_globals()
	$MarginContainer/VBoxContainer/TextureButton.grab_focus();
	ScreenText.get_node("PowerUpText").text = "A Game by Daniel \"Vulpon\" Gazzaneo";


func _process(delta):
	if($MarginContainer/VBoxContainer/TextureButton.is_hovered()):
		$MarginContainer/VBoxContainer/TextureButton.grab_focus();
	if($MarginContainer/VBoxContainer/TextureButton2.is_hovered()):
		$MarginContainer/VBoxContainer/TextureButton2.grab_focus();


func _on_TextureButton_pressed():
	ScreenText.get_node("PowerUpText").text = "";
	get_tree().change_scene("res://SCENES/World.tscn");


func _on_TextureButton2_pressed():
	get_tree().quit();
