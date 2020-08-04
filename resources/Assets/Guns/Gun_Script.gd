extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bullet_template := preload("res://resources/Assets/Bullets/default_bullet.tscn")
var fire_rate := 10 # will fix this later

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#bullet delay: the amount of time it takes between each bullet to be fired
#direction - the direction that the bullet will be shot at.
func shoot(direction):
	var bullet := bullet_template.instance()
	bullet.set_direction(direction)
	bullet.transform = get_node("GunSprite/BulletExit").transform
	add_child(bullet)
	pass
