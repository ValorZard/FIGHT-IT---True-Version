extends Node2D

class_name GunScript

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export onready var bullet_template := preload("res://resources/Assets/Bullets/default_bullet.tscn")
export var bullet_speed := 100
export onready var time_till_next_bullet := get_node("time_till_next_bullet")
export var fire_rate := 0.5 #seconds before next bullet
export var inbetween_angle := PI/6 #the angle between mulple bullets
export var belongs_to_player := true
# Called when the node enters the scene tree for the first time.
func _ready():
	time_till_next_bullet.start(fire_rate)
	time_till_next_bullet.one_shot = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawn_bullet(direction):
	var bullet := bullet_template.instance()
	bullet.set_direction(direction)
	bullet.bullet_speed = bullet_speed
	bullet.belongs_to_player = belongs_to_player
	bullet.global_position = get_node("BulletExit").global_position
	get_tree().get_root().add_child(bullet)

#bullet delay: the amount of time it takes between each bullet to be fired
#direction - the direction that the bullet will be shot at.
func shoot(direction, number_of_bullets):
	if(time_till_next_bullet.time_left <= 0):
		#THIS CODE DOESNT WORK
		if(number_of_bullets % 2 == 0):
			#left side
			#loop for the rest of the left bullets
			var i = 0
			while (i < ((number_of_bullets)/2)):
				var offset = Vector2(cos(inbetween_angle * i), sin(inbetween_angle * i))
				spawn_bullet(direction + offset)
				i += 1
				pass
			#right side
			#loop for the rest of the right side
			i = 0
			while (i < ((number_of_bullets)/2)):
				var offset = Vector2(cos(inbetween_angle * i), sin(inbetween_angle * i))
				spawn_bullet(direction - offset)
				i += 1
				pass
		#THIS CODE DOES WORK
		else:
			#middle one
			spawn_bullet(direction)
			#left side
			var i = 0
			while (i < ((number_of_bullets- 1)/2)):
				var offset = Vector2(cos(inbetween_angle * i), sin(inbetween_angle * i))
				spawn_bullet(direction + offset)
				i += 1
				pass
			#right side
			i = 0
			while (i < ((number_of_bullets- 1)/2)):
				var offset = Vector2(cos(inbetween_angle * i), sin(inbetween_angle * i))
				spawn_bullet(direction - offset)
				i += 1
				pass
		time_till_next_bullet.start(fire_rate)
	pass


func get_time_till_next_bullet():
	return time_till_next_bullet.time_left
