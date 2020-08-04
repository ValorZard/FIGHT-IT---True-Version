extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bullet_speed := 100
var bullet_direction := Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_collide(bullet_speed * bullet_direction * delta)
	pass

func on_hit(body):
	self.queue_free()
	pass

func _on_Area2D_body_entered(body):
	on_hit(body)
	pass # Replace with function body.
