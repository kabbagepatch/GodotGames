extends Node2D

@onready var ball: StaticBody2D = $Ball
@onready var start_timer: Timer = $StartTimer
@onready var hud: CanvasLayer = $HUD
@onready var separator: Sprite2D = $Separator
var rng = RandomNumberGenerator.new()
var time_start = 0

var p1_score = 0
var p2_score = 0
var recent_player_win = 1

func _ready():
	start_timer.start()
	separator.hide()
	hud.show_message("0 - 0", "GET READY")
	time_start = Time.get_unix_time_from_system()

func _on_p1_hit():
	ball.velocity = Vector2(1 + (floorf(Time.get_unix_time_from_system() - time_start) / 50), rng.randf_range(-1, 1))

func _on_p2_hit():
	ball.velocity = Vector2(-1 - (floorf(Time.get_unix_time_from_system() - time_start) / 50), rng.randf_range(-1, 1))

func _on_player_scored(player):
	recent_player_win = player
	if player == 1:
		p1_score += 1
	else:
		p2_score += 1

	ball.reset()
	separator.hide()
	var message = "GET READY"
	var game_over = false
	if p1_score == 5 or p2_score == 5:
		message = "GAME OVER"
		game_over = true
	else:
		start_timer.start()

	hud.show_message("%s - %s" % [p1_score, p2_score], message, game_over)

func _on_start_timer_timeout() -> void:
	ball.start(recent_player_win * 2 - 3)
