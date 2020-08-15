extends KinematicBody2D

class_name Enemy


#var enemy_angle := 0

onready var enemy_health = 10

var shield_health := 10
var shield_pressed := false

onready var is_shooting := false

var gun_direction = Vector2()
var gun_angle = 0


onready var current_gun := get_node("Gun")

# Called when the node enters the scene tree for the first time.
func _ready():
	gun_direction = GunMath.rad2vector(gun_angle)
	#current_gun.belongs_to_player = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#set_direction()
	do_attack(delta)
	pass


func do_attack(delta):
	if(is_shooting):
		current_gun.shoot(gun_direction)
		pass
	pass

func on_hit(damage):
	enemy_health -= damage
	if(enemy_health <= 0):
		death()
	pass

func death():
	queue_free()

func _to_string():
	var enemy_string := ""
	
	enemy_string += "Health:" + str(enemy_health) + "\n"
	
	enemy_string += "Shield: " + str(shield_pressed) + "\nShield Health: " + str(shield_health) + "\n"
	
	enemy_string += "Shooting: " + str(is_shooting) + "\n"
	
	enemy_string += "Time till Next Bullet: " + str(current_gun.get_time_till_next_bullet()) + "\n"

	return enemy_string
