extends Node

class_name GunMath

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

static func rad2vector(angle):
	return Vector2(cos(angle), sin(angle))
	pass

static func deg2vector(angle):
	angle = deg2rad(angle)
	return Vector2(cos(angle), sin(angle))
	pass
