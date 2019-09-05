extends Node2D

var cont = 1;
onready var scrtext = ScreenText.get_node("PowerUpText");
onready var textTimer = $"Text Timers/TextTimer";

func _ready():
	scrtext.text = "The only way to get to safety and happiness";
	textTimer.start(2.5);

func _on_Text1_timeout():
	match cont:
		1: 
			scrtext.text = "Is out of this cave!";
			cont += 1;
		2:
			scrtext.text = "Good Luck!";
			cont += 1;
			globals.can_move = true;
		3:
			scrtext.text = "";
			cont = 0;
			textTimer.stop();