extends Label

func _ready():
	text = "";

func _change_text(new_text):
	text = new_text;
	$Timer.start(2);

func _on_Timer_timeout():
	text = "";
