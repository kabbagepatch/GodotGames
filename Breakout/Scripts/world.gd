extends Node2D

@onready var paddle: Paddle = $Paddle
@onready var ball: CharacterBody2D = $Ball
@onready var hud: CanvasLayer = $HUD
@onready var menu: Control = $Menu
@onready var life_lost: AudioStreamPlayer = $LifeLost
@onready var game_over: AudioStreamPlayer = $GameOver

const BRICK_SCENE = preload("res://Scenes/brick.tscn")

const ROWS = 10
const COLS = 16
const START_X = 96
const START_Y = 100
const WIDTH = 64
const HEIGHT = 32

var game_state = 'READY'
var lives = 3
var total_score = 0

func _ready() -> void:
	ball.hide()
	hud.hide_message()

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()
	if Input.is_key_pressed(KEY_SPACE) and game_state == 'READY':
		game_state = 'PLAY'
		paddle.game_state = 'PLAY'
		ball.game_state = 'PLAY'
		ball.velocity = Vector2(1, -1)
		hud.hide_message()

func _on_menu_start_game() -> void:
	ball.show()
	menu.hide()
	hud.show_message()
	game_state = 'READY'
	paddle.game_state = 'READY'
	ball.game_state = 'READY'
	for i in range(ROWS):
		for j in range(COLS):
			var brick = BRICK_SCENE.instantiate() as StaticBody2D
			brick.global_position = Vector2(START_X + WIDTH * j, START_Y + HEIGHT * i)
			brick.scored.connect(update_score)
			brick.frame = ((ROWS - i - 1) / 2) * 3
			if i >= 6:
				brick.hits = 1
			elif i >= 4:
				brick.hits = 2
			else:
				brick.hits = 3
			add_child(brick)

func update_score(score):
	total_score += score
	hud.update_score(total_score)

func _on_ball_life_lost() -> void:
	lives -= 1
	paddle.global_position = Vector2(556, 610)
	ball.global_position = Vector2(576, 595)
	ball.speed = 3
	if lives < 0:
		game_over.play()
		hud.update_message('GAME OVER')
		ball.queue_free()
		game_state = 'GAME_OVER'
		paddle.game_state = 'GAME_OVER'
		ball.game_state = 'GAME_OVER'
	else:
		life_lost.play()
		hud.update_lives(lives)
		game_state = 'READY'
		paddle.game_state = 'READY'
		ball.game_state = 'READY'

	hud.show_message()
