extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bullet_speed := 100
var bullet_direction := Vector2()
var life_span := 5 #seconds
onready var life_timer := get_node("LifeTimer")


# Called when the node enters the scene tree for the first time.
func _ready():
	life_timer.start(life_span)
	life_timer.one_shot = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(life_timer.time_left > 0):
		move_and_collide(bullet_speed * bullet_direction * delta)
	else:
		destroy()
	pass

func set_direction(direction):
	bullet_direction = direction

#when the bullet hits something
func on_hit(body):
	#self.queue_free()
	pass

func destroy():
	self.queue_free()
	pass

