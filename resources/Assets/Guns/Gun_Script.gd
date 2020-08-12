extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bullet_template := preload("res://resources/Assets/Bullets/default_bullet.tscn")
onready var time_till_next_bullet := get_node("time_till_next_bullet")
onready var fire_rate := 0.1 #seconds before next bullet
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
		bullet.position = get_node("BulletExit").position
		get_parent().add_child(bullet)
		time_till_next_bullet.start(fire_rate)
	pass

func get_time_till_next_bullet():
	return time_till_next_bullet.time_left
