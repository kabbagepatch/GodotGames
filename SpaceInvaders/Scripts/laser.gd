extends Area2D
class_name Laser

var speed = 300
var go_down = false

func _process(delta):
	if (position.y < -10):
		queue_free()
	
	position.y -= delta * speed
