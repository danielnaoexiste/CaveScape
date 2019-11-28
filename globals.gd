extends Node

# Used for global variables
# Ex: PowerUp Variables
# This way they can mantain their 
# value easily through scenes

var can_move = false;
var finished = false;

# Power Up Variables
var n_chest = 0;
var MAX_JUMP_COUNT = 1;
var can_wall_jump = false;
var can_duck = false;
var can_shoot = false;
var has_cake = false;
var keys = 0;

func _reset_globals():
	can_move = false;
	finished = false;
	n_chest = 0;
	MAX_JUMP_COUNT = 1;
	can_wall_jump = false;
	can_duck = false;
	can_shoot = false;
	has_cake = false;
	keys = 0;