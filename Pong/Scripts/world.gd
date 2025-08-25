extends Node2D

@onready var player_1: Area2D = $Player1
@onready var player_2: Area2D = $Player2
@onready var ball: StaticBody2D = $Ball
@onready var start_timer: Timer = $StartTimer
@onready var hud: CanvasLayer = $HUD
@onready var separator: Sprite2D = $Separator
@onready var menu: Control = $Menu

var rng = RandomNumberGenerator.new()
var time_start = 0
var game_started = 0

var p1_score = 0
var p2_score = 0
var recent_player_win = 1

var ai_start = false
var ai_velocity = 0
var ai_threshold = 40

func _ready():
	ball.hide()
	hud.hide()
	separator.hide()

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()

func _on_menu_start_game(mode) -> void:
	start_timer.start()
	separator.hide()
	game_started = true
	player_2.mode = mode
	ball.show()
	hud.show()
	hud.show_message("0 - 0", "GET READY")
	menu.hide()
	time_start = Time.get_unix_time_from_system()

func _on_p1_hit():
	ball.velocity = Vector2(1 + (floorf(Time.get_unix_time_from_system() - time_start) / 100), rng.randf_range(-1, 1))

func _on_p2_hit():
	ball.velocity = Vector2(-1 - (floorf(Time.get_unix_time_from_system() - time_start) / 100), rng.randf_range(-1, 1))

func _on_player_scored(player):
	recent_player_win = player
	if player == 1:
		p1_score += 1
	else:
		p2_score += 1
	if p1_score >= 5 or p2_score >= 5:
		game_over()
		ball.reset()
	else:
		time_start = Time.get_unix_time_from_system()
		ball.reset()
		separator.hide()
		start_timer.start()
		hud.show_message("%s - %s" % [p1_score, p2_score], "GET READY", false)

func _on_start_timer_timeout() -> void:
	ball.start(recent_player_win * 2 - 3)
	if recent_player_win == 2:
		player_2.computer_start = true

func game_over() -> void:
	game_started = false
	hud.show_message("%s - %s" % [p1_score, p2_score], "GAME OVER", true)
