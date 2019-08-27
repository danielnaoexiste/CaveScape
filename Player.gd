extends KinematicBody2D

const UP = Vector2(0, -1);
const GRAVITY = 5;
const ACCELERATION = 15;
const MAX_SPEED = 80;
const JUMP_HEIGHT = -150;
const PUSH_SPEED = 45;

var motion = Vector2();
var is_alive = true;

var n_chest = 0;

var jump_count = 0;
var MAX_JUMP_COUNT = 1;

var can_wall_jump = false;

var on_ground = false;

onready var step_audio : AudioStreamPlayer2D = $StepSound;
onready var jump_audio : AudioStreamPlayer2D = $JumpSound;
onready var step_timer : Timer = $StepTimer;
onready var dust_scene = load("res://EFFECTS/Particles2D.tscn");

# Footsteps
func _on_StepTimer_timeout():
	step_audio.set_pitch_scale(rand_range(0.5, 1));
	step_audio.play();

func _ready():
	step_timer.start(.35);
	step_timer.set_paused(true);

func _physics_process(delta):
	# Gravity
	motion.y += GRAVITY;
	
	_get_input();
	
	motion = move_and_slide(motion, UP);
	
func _get_input():

	#Character Movement
	var friction = false;
	if is_alive:
		if(Input.is_action_pressed("ui_right")):
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED);
			
			$AnimatedSprite.flip_h = false;
			$AnimatedSprite.play("Run");
			
			_spawn_dust(0, position.x, position.y + 8);
			
			if is_on_floor():
				step_timer.set_paused(false);
			else:
				step_timer.set_paused(true);
			
		elif(Input.is_action_pressed("ui_left")):
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED);
			
			$AnimatedSprite.flip_h = true;
			$AnimatedSprite.play("Run");
			
			_spawn_dust(1, position.x, position.y + 8);
			
			if is_on_floor():
				step_timer.set_paused(false);
			else:
				step_timer.set_paused(true);
		else:
			$AnimatedSprite.play("Idle");
			step_timer.set_paused(true);
			friction = true;

		# Jump Mechanics
		if jump_count < MAX_JUMP_COUNT:
			if(Input.is_action_just_pressed("ui_jump")):
				motion.y = JUMP_HEIGHT;
				jump_audio.set_pitch_scale(rand_range(0.75, 1));
				jump_audio.play();
				on_ground = false;
				jump_count += 1;
				print(jump_count);

		 # Controls Double Jump
		if is_on_floor():
			if on_ground == false:
				on_ground = true;
				jump_count = MAX_JUMP_COUNT;

			if motion.y >= 0:
				jump_count = 0;
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2);

		else:
			if on_ground == true:
				on_ground == false;
				jump_count = 1;
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.05);
			if motion.y < 0:
				$AnimatedSprite.play("Jump");
			else:
				if can_wall_jump:
					for i in get_slide_count():
						var collision = get_slide_collision(i).get_normal();
						if collision == Vector2(1, 0) or Vector2(-1, 0):
							motion.y -= GRAVITY/2;
							if(Input.is_action_just_pressed("ui_jump")):
								motion.y = JUMP_HEIGHT/1.2;
								if ($AnimatedSprite.flip_h):
									motion.x = 125;
								else:
									motion.x = -125;
								jump_audio.set_pitch_scale(rand_range(0.75, 1));
								jump_audio.play();
				$AnimatedSprite.play("Fall");

func _spawn_dust(dir, x, y):
	# Spawns Dust
	var dust = dust_scene.instance();
	dust.position = Vector2(x, y);
	var world = get_parent().get_node("TileMap");
	if dir == 1:
		dust.rotation_degrees = 350;
	else:
		dust.rotation_degrees = 190;
	if (world.has_node("Particles2D")):
		return;
	
	if is_on_floor():
		world.add_child(dust);