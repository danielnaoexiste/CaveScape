extends Control

onready var main_menu = $"MainMenu"
onready var settings_menu = $"SettingsMenu"

onready var screen_text = get_node("/root/ScreenText");
onready var play_button = $"MainMenu/Main Menu/Play"
onready var settings_button = $"MainMenu/Main Menu/Settings"
onready var quit_button = $"MainMenu/Main Menu/Quit"
onready var return_button = $"SettingsMenu/CenterContainer/Settings/Return"


func _ready():
	globals._reset_globals()
	play_button.grab_focus()
	
	main_menu.visible = true
	settings_menu.visible = false
	
	if (OS.has_feature("web") or OS.has_feature("debug")):
		quit_button.visible = false

func _process(delta):
	if(play_button.is_hovered()):
		play_button.grab_focus()
	if(settings_button.is_hovered()):
		settings_button.grab_focus()
	if(quit_button.is_hovered()):
		quit_button.grab_focus()

func _on_Play_pressed():
	get_tree().change_scene("res://SCENES/World.tscn");


func _on_Settings_pressed():
	settings_menu.visible = true
	main_menu.visible = false
	return_button.grab_focus()


func _on_Quit_pressed():
	get_tree().quit();


func _on_Return_pressed():
	settings_menu.visible = false
	main_menu.visible = true
	play_button.grab_focus()

