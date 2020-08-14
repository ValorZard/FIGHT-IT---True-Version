extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bullet_speed := 100
var bullet_direction := Vector2()
var bullet_velocity := Vector2()
var life_span := 5 #seconds
onready var life_timer := get_node("LifeTimer")


# Called when the node enters the scene tree for the first time.
func _ready():
	life_timer.start(life_span)
	life_timer.one_shot = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	bullet_velocity = bullet_speed * bullet_direction 
	if(life_timer.time_left > 0):
		#var player_velocity = get_parent().get_parent().player_velocity
		move_and_collide((bullet_velocity) * delta)
	else:
		destroy()
	pass

func set_direction(direction):
	bullet_direction = direction

#when the bullet hits something
func on_hit(body):
	#self.queue_free()
	destroy()
	pass

#destroy bullet
#might add animations or sounds or something later
func destroy():
	queue_free()
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("Collision"):
		on_hit(body)
	pass # Replace with function body.
