extends Control

onready var main_container = $"CenterContainer/Game Paused"
onready var settings_container = $"CenterContainer/Settings"

onready var resume_button = $"CenterContainer/Game Paused/Resume"
onready var settings_button = $"CenterContainer/Game Paused/Settings"
onready var quit_button = $"CenterContainer/Game Paused/Quit"
onready var return_button = $"CenterContainer/Settings/Return"

var is_paused = false setget set_is_paused
var current_menu = 0


func _ready():
	main_container.visible = true
	settings_container.visible = false
	
	resume_button.grab_focus()
	
	if (OS.has_feature("web") or OS.has_feature("debug")):
		quit_button.visible = false


func _unhandled_input(event):
	if is_paused and event.is_action_pressed("ui_return"):
		if current_menu == 1:
			 _on_Return_pressed() 
		else: 
			self.is_paused = false
	
	if event.is_action_pressed("ui_pause"):
		if current_menu == 0:
			self.is_paused = !is_paused
			resume_button.grab_focus()
		else: 
			_on_Return_pressed()

func _process(delta):
	if(resume_button.is_hovered()):
		resume_button.grab_focus()
	if(settings_button.is_hovered()):
		settings_button.grab_focus()
	if(quit_button.is_hovered()):
		quit_button.grab_focus()
	if(return_button.is_hovered()):
		return_button.grab_focus()



func set_is_paused(paused):
	is_paused = paused
	get_tree().paused = is_paused
	visible = is_paused


func _on_Resume_pressed():
	self.is_paused = false


func _on_Settings_pressed():
	current_menu = 1
	settings_container.visible = true
	main_container.visible = false
	return_button.grab_focus()


func _on_Quit_pressed():
	get_tree().quit()


func _on_Return_pressed():
	settings_container.visible = false
	main_container.visible = true
	current_menu = 0
	resume_button.grab_focus()