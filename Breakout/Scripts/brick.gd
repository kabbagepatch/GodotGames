extends StaticBody2D
class_name Brick

signal scored(score)

const POWERUP = preload("uid://b47sc3wa0yolt")
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var frame: int
@export var hits: int
@export var score = 20
var rng

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	sprite_2d.frame = frame

func hit():
	hits -= 1
	if hits <= 0:
		emit_signal("scored", score)
		var random_int = rng.randi_range(1, 10)
		if random_int <= 3:
			var powerup = POWERUP.instantiate() as Area2D
			powerup.global_position = position
			powerup.global_position.y += 10
			add_sibling(powerup)
		queue_free()
	elif hits <= 1:
		sprite_2d.frame = frame + 2
	else:
		sprite_2d.frame = frame + 1
