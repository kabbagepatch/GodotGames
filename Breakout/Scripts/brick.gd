extends StaticBody2D
class_name Brick

@export var frame: int
@export var hits: int

signal scored(score)
@onready var sprite_2d: Sprite2D = $Sprite2D

var score = 20

func _ready():
	sprite_2d.frame = frame

func hit():
	hits -= 1
	if hits <= 0:
		emit_signal("scored", score);
		queue_free()
	elif hits <= 1:
		sprite_2d.frame = frame + 2
	else:
		sprite_2d.frame = frame + 1
