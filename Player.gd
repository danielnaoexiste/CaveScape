extends KinematicBody2D

# Movement Variables
const UP = Vector2(0, -1);
const GRAVITY = 5;
const ACCELERATION = 15;
const MAX_SPEED = 80;
const JUMP_HEIGHT = -150;
const PUSH_SPEED = 45;

const DUCK_ACC = 10;
const DUCK_MAXSPD = 60;

const bullet_scene = preload("res://Props/Bullet.tscn");
const dust_scene = preload("res://EFFECTS/Particles2D.tscn");

var motion = Vector2();

# Power Up Variables
var jump_count = 0;

var on_duck = false;
var on_ground = false;
var on_shoot = false;

onready var step_audio : AudioStreamPlayer2D = $Sounds/StepSound;
onready var jump_audio : AudioStreamPlayer2D = $Sounds/JumpSound;
onready var shoot_audio : AudioStreamPlayer2D = $Sounds/ShootSound;
onready var step_timer : Timer = $StepTimer;


onready var cam = $Camera2D
onready var camhandler = $CamHandler
onready var spawn_point = get_tree().get_root().get_node("World").get_node("Spawn Point");

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
	
	_camera_snap();
	
func _get_input():

	#Character Movement
	var friction = false;
	if (!globals.can_move):
		$AnimatedSprite.play("Idle");
	else:
		if(Input.is_action_pressed("ui_right")):
			if(!on_duck):
				motion.x = min(motion.x + ACCELERATION, MAX_SPEED);
				
				$AnimatedSprite.flip_h = false;
				$AnimatedSprite.play("Run");
			else:
				motion.x = min(motion.x + DUCK_ACC, DUCK_MAXSPD);
				$AnimatedSprite.flip_h = false;
				$AnimatedSprite.play("duckRun");
			
			if is_on_floor():
				step_timer.set_paused(false);
				_spawn_dust(0, position.x, position.y + 8);
			else:
				step_timer.set_paused(true);
			
		elif(Input.is_action_pressed("ui_left")):
			if (!on_duck):
				motion.x = max(motion.x - ACCELERATION, -MAX_SPEED);
				
				$AnimatedSprite.flip_h = true;
				$AnimatedSprite.play("Run");
			else: 
				motion.x = max(motion.x - DUCK_ACC, -DUCK_MAXSPD);
				
				$AnimatedSprite.flip_h = true;
				$AnimatedSprite.play("duckRun");
			
			if is_on_floor():
				step_timer.set_paused(false);
				_spawn_dust(1, position.x, position.y + 8);
			
		elif (Input.is_action_pressed("ui_down") and globals.can_duck):
			on_duck = true;
			$CollisionShape2D.get_shape().set_extents(Vector2(4.5, 4));
			$CollisionShape2D.position = Vector2(0.471, 0.12);
			$AnimatedSprite.play("duckIdle");
				
			if !Input.is_action_pressed("ui_right") or !Input.is_action_pressed("ui_left"):
				friction = true;
				step_timer.set_paused(true);
		else:
			on_duck = false;
			$CollisionShape2D.get_shape().set_extents(Vector2(4.5, 6.54));
			$CollisionShape2D.position = Vector2(0.471, 1.596);
			$AnimatedSprite.play("Idle");
			step_timer.set_paused(true);
			friction = true;
		
		if (Input.is_action_just_pressed("ui_shoot") && globals.can_shoot && !on_shoot):
			var bullet = bullet_scene.instance();
			on_shoot = true;
			$"Bullet Timer".start(0.5);
			if !$AnimatedSprite.flip_h:
				$"Bullet Pos".position.x = 5;
				bullet._set_bullet_direction(1);
			else:
				$"Bullet Pos".position.x = -8.5;
				bullet._set_bullet_direction(-1);
			
			shoot_audio.set_pitch_scale(rand_range(0.75, 1));
			shoot_audio.play();
			$Camera2D/ScreenShake._start(0.2, 25, 2, 1);
			get_parent().add_child(bullet);
			bullet.position = $"Bullet Pos".global_position;
		
			# Jump Mechanics
		if jump_count < globals.MAX_JUMP_COUNT:
			if(Input.is_action_just_pressed("ui_jump")):
				motion.y = JUMP_HEIGHT;
				jump_audio.set_pitch_scale(rand_range(0.75, 1));
				jump_audio.play();
				on_ground = false;
				jump_count += 1;
				step_timer.set_paused(true);
			 # Controls Double Jump
		if is_on_floor():
			if on_ground == false:
				on_ground = true;
				jump_count = globals.MAX_JUMP_COUNT;
	
			if motion.y >= 0:
				jump_count = 0;
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2);
	
		else:
			if on_ground == true:
				on_ground == false;
				jump_count = 1;
			#	step_timer.set_paused(true);
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.05);
			if motion.y < 0:
				$AnimatedSprite.play("Jump");
			else:
				if globals.can_wall_jump:
					for i in get_slide_count():
						var collision = get_slide_collision(i).get_normal();
						if collision == Vector2(1, 0) or Vector2(-1, 0):
							motion.y -= GRAVITY/2 as int;
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
	if on_duck:
		y -= 4;
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
		
func _camera_snap():
	for area in camhandler.get_overlapping_areas():
		if area.is_in_group("camera_snap"):
			spawn_point.position = area.position + area.get_node("SpawnPosition").position * area.scale;
			cam.limit_left = area.position.x;
			cam.limit_right = area.position.x + 280 * area.scale.x;
			cam.limit_top = area.position.y;
			cam.limit_bottom = area.position.y + 180 * area.scale.y;

func _on_Bullet_Timer_timeout():
	on_shoot = false;