extends StaticBody2D
class_name Brick

signal scored(score)

var score = 100

func hit():
	emit_signal("scored", score);
	queue_free()
