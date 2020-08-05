extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var x_input := 0.0
var y_input := 0.0
var player_speed := 200.0
var dash_multiplier := 2.0
var is_dashing := false
var player_velocity := Vector2()

enum Direction{UP, DOWN, LEFT, RIGHT, UP_LEFT, UP_RIGHT, DOWN_LEFT, DOWN_RIGHT}
var current_direction = Direction.UP

var player_angle := 0

var shield_health := 10
var shield_pressed := false

var is_shooting := false

var special_pressed := false

var melee_pressed := false

enum States{IDLE, WALK, DASH} #ONLY ALLOWED TO HAVE ONE STATE AT A TIME
var current_state = States.IDLE

onready var current_gun = get_node("Gun")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_gun_rotation()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input(delta)
	set_movement(delta)
	set_direction()
	set_gun_rotation()
	set_state(delta)
	do_attack(delta)
	pass

func get_input(delta):
	x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	y_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if(Input.is_action_pressed("shield")):
		shield_pressed = true
	else:
		shield_pressed = false
	
	if(Input.is_action_pressed("dash_button")):
		is_dashing = true
	else:
		is_dashing = false
	
	if(Input.is_action_pressed("shoot")):
		is_shooting = true
	else:
		is_shooting = false
	
	if(Input.is_action_pressed("special_move")):
		special_pressed = true
	else:
		special_pressed = false
	
	if(Input.is_action_pressed("interact_melee")):
		melee_pressed = true
	else:
		melee_pressed = false
	
	pass



func set_movement(delta):
	player_velocity = player_speed * Vector2(x_input,y_input)
	
	if(player_velocity != Vector2.ZERO):
		if(is_dashing):
			current_state = States.DASH
		else:
			current_state = States.WALK
	pass

func set_direction():
	player_angle = atan2(player_velocity.y, player_velocity.x)
	print(rad2deg(player_angle))
	#SET DIRECTION
	if(rad2deg(player_angle) > -45/2 and rad2deg(player_angle) < 45/2):
		current_direction = Direction.RIGHT
	elif(rad2deg(player_angle) > -135/2 and rad2deg(player_angle) < -45/2):
		current_direction = Direction.UP_RIGHT
	elif(rad2deg(player_angle) > -225/2 and rad2deg(player_angle) < -135/2):
		current_direction = Direction.UP
	elif(rad2deg(player_angle) > -315/2 and rad2deg(player_angle) < -225/2):
		current_direction = Direction.UP_LEFT
	elif(rad2deg(player_angle) < -315/2 or rad2deg(player_angle) > 315/2):
		current_direction = Direction.LEFT
	elif(rad2deg(player_angle) > 225/2 and rad2deg(player_angle) < 315/2):
		current_direction = Direction.DOWN_LEFT
	elif(rad2deg(player_angle) > 135/2 and rad2deg(player_angle) < 225/2):
		current_direction = Direction.DOWN
	elif(rad2deg(player_angle) > 45/2 and rad2deg(player_angle) < 135/2):
		current_direction = Direction.DOWN_RIGHT
	pass

func set_gun_rotation():
	current_gun.rotation_degrees = rad2deg(player_angle)
	pass

func set_state(delta):
	#basic state machine
	match(current_state):
		States.IDLE:
			do_during_idle(delta)
		States.WALK: 
			do_during_walk(delta)
		States.DASH:
			do_during_dash(delta)

func do_during_idle(delta):
	pass

func do_during_walk(delta):
	move_and_collide(player_velocity * delta)

func do_during_dash(delta):
	move_and_collide(dash_multiplier * player_velocity * delta)

func do_attack(delta):
	if(is_shooting):
		var direction := Vector2(cos(player_angle), sin(player_angle))
		current_gun.shoot(direction)
		pass
	pass

func _to_string():
	var player_string := ""
	player_string += "Current State: "
	
	match(current_state):
		States.IDLE:
			player_string += "IDLE"
		States.WALK: 
			player_string += "WALK"
		States.DASH:
			player_string += "DASH"
	
	player_string += "\n"
	
	player_string += "Player Direction: "
	
	match(current_direction):
		Direction.RIGHT:
			player_string += "RIGHT"
		Direction.UP_RIGHT:
			player_string += "UP_RIGHT"
		Direction.UP:
			player_string += "UP"
		Direction.UP_LEFT:
			player_string += "UP_LEFT"
		Direction.LEFT:
			player_string += "LEFT"
		Direction.DOWN_LEFT:
			player_string += "DOWN_LEFT"
		Direction.DOWN:
			player_string += "DOWN"
		Direction.DOWN_RIGHT:
			player_string += "DOWN_RIGHT"
	
	player_string += "\n"
	
	player_string += "Angle: " + str(rad2deg(player_angle)) + "\n"
	
	player_string += "Shield: " + str(shield_pressed) + "\nShield Health: " + str(shield_health) + "\n"
	
	player_string += "Shooting: " + str(is_shooting) + "\n"
	
	player_string += "Special: " + str(special_pressed) + "\n"
	
	player_string += "Melee: " + str(melee_pressed) + "\n"
	
	return player_string
