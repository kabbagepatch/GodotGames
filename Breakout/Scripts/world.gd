extends Node2D

const BRICK_SCENE = preload("res://Scenes/brick.tscn")

const ROWS = 10
const COLS = 16
const START_X = 100
const START_Y = 100
const WIDTH = 64
const HEIGHT = 32

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(ROWS):
		for j in range(COLS):
			var brick = BRICK_SCENE.instantiate() as Area2D
			brick.global_position = Vector2(START_X + WIDTH * j, START_Y + HEIGHT * i)
			add_child(brick)
