extends Node2D

class_name GunScript

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export onready var bullet_template := preload("res://resources/Assets/Bullets/default_bullet.tscn")
export onready var bullet_speed := 300
export onready var time_till_next_bullet := get_node("time_till_next_bullet")
export onready var fire_rate := 0.2 #seconds before next bullet
export onready var belongs_to_player := true
# Called when the node enters the scene tree for the first time.
func _ready():
	time_till_next_bullet.start(fire_rate)
	time_till_next_bullet.one_shot = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#bullet delay: the amount of time it takes between each bullet to be fired
#direction - the direction that the bullet will be shot at.
func shoot(direction):
	if(time_till_next_bullet.time_left <= 0):
		var bullet := bullet_template.instance()
		bullet.set_direction(direction)
		bullet.bullet_speed = bullet_speed
		bullet.belongs_to_player = belongs_to_player
		bullet.global_position = get_node("BulletExit").global_position
		get_tree().get_root().add_child(bullet)
		time_till_next_bullet.start(fire_rate)
	pass

func get_time_till_next_bullet():
	return time_till_next_bullet.time_left
