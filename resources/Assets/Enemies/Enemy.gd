extends KinematicBody2D

class_name Enemy


#var enemy_angle := 0

export var default_health := 10
export(int) var enemy_health := default_health

export var default_shield := 10
export(int) var shield_health := default_shield
var shield_pressed := false

export var is_shooting := true

var gun_direction = Vector2()
export var gun_angle := 0

export var gun_fire_rate := 0.2

export onready var current_gun := get_node("Gun")

# Called when the node enters the scene tree for the first time.
func _ready():
	gun_direction = GunMath.deg2vector(gun_angle)
	current_gun.belongs_to_player = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#set_direction()
	set_gun_values()
	do_attack(delta)
	pass


func do_attack(delta):
	if(is_shooting):
		current_gun.shoot(gun_direction)
		pass
	pass

func set_gun_values():
	#current_gun.rotation_degrees = rad2deg(player_angle)
	current_gun.rotation_degrees = gun_angle
	current_gun.fire_rate = gun_fire_rate
	pass

func on_hit(damage):
	enemy_health -= damage
	if(shield_health > 0):
		shield_health -= damage
	elif(enemy_health > 0):
		enemy_health -= damage
	else:
		death()
	pass

func death():
	queue_free()
	pass

func _to_string():
	var enemy_string := ""
	
	enemy_string += "Health:" + str(enemy_health) + "\n"
	
	enemy_string += "Shield: " + str(shield_pressed) + "\nShield Health: " + str(shield_health) + "\n"
	
	enemy_string += "Shooting: " + str(is_shooting) + "\n"
	
	enemy_string += "Time till Next Bullet: " + str(current_gun.get_time_till_next_bullet()) + "\n"

	return enemy_string
