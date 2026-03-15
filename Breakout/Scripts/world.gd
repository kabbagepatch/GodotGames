extends Node2D

@onready var paddle: Paddle = $Paddle
@onready var ball: CharacterBody2D = $Ball
@onready var hud: CanvasLayer = $HUD

const BRICK_SCENE = preload("res://Scenes/brick.tscn")

const ROWS = 10
const COLS = 16
const START_X = 100
const START_Y = 100
const WIDTH = 64
const HEIGHT = 32

var game_state = 'READY'
var lives = 3
var total_score = 0

func _ready() -> void:
	for i in range(ROWS):
		for j in range(COLS):
			var brick = BRICK_SCENE.instantiate() as StaticBody2D
			brick.global_position = Vector2(START_X + WIDTH * j, START_Y + HEIGHT * i)
			brick.scored.connect(update_score)
			add_child(brick)

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()
	if Input.is_key_pressed(KEY_SPACE):
		game_state = 'PLAY'
		paddle.game_state = 'PLAY'
		ball.game_state = 'PLAY'
		ball.velocity = Vector2(1, -1)
		hud.hide_message()

func update_score(score):
	total_score += score
	hud.update_score(total_score)
