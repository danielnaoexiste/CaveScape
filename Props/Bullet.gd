extends Area2D

const SPEED = 100;
var velocity = Vector2();
var direction = 1;

func _physics_process(delta):
	velocity.x = SPEED * delta * direction;
	translate(velocity);

func _set_bullet_direction(dir):
	direction = dir;

func _on_VisibilityEnabler2D_screen_exited():
	queue_free();

func _on_Bullet_body_entered(body):
	queue_free();
