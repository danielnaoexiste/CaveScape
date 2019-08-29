extends Area2D

const SPEED = 100;
var velocity = Vector2();
var direction = 1;

onready var player = get_node("../Player");

func _physics_process(delta):
	velocity.x = SPEED * delta * direction;
	translate(velocity);

func _set_bullet_direction(dir):
	direction = dir;

func _on_VisibilityEnabler2D_screen_exited():
	queue_free();

func _on_Bullet_body_entered(body):
	if body.is_in_group("Destructable"):
		player.get_node("Camera2D/ScreenShake")._start(0.2, 25, 2, 1);
		player.get_node("Sounds/HitSound").play();
		body.queue_free();
	queue_free();
