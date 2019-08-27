extends Label

const items: Array = [
	'Double Jump',
	'Wall Jump', 
	'Cake',
	'Ultra Weapon',
	'Duck'
];

func _ready():
	randomize();
	text = "";

func _change_text(new_text):
	text = new_text + get_random_item();
	$Timer.start(2);

func _on_Timer_timeout():
	text = "";

static func get_random_item() -> String:
	return items[randi() % len(items)] as String;