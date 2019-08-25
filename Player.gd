extends KinematicBody2D

const UP = Vector2(0, -1);
const GRAVITY = 5;
const ACCELERATION = 15;
const MAX_SPEED = 80;
const JUMP_HEIGHT = -150;
const PUSH_SPEED = 45;

var motion = Vector2();
var is_alive = true;

func _physics_process(delta):
	motion.y += GRAVITY;
	_get_input();
	motion = move_and_slide(motion, UP);
	
func _get_input():
	var friction = false;
	if is_alive:
		if(Input.is_action_pressed("ui_right")):
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED);
			
			$AnimatedSprite.flip_h = false;
			$AnimatedSprite.play("Run");
			
		elif(Input.is_action_pressed("ui_left")):
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED);
			
			$AnimatedSprite.flip_h = true;
			$AnimatedSprite.play("Run");
		else:
			$AnimatedSprite.play("Idle");
			friction = true;
		if is_on_floor():
			if(Input.is_action_just_pressed("ui_jump")):
				motion.y = JUMP_HEIGHT
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2);
		else:
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.05);
				
				
				
