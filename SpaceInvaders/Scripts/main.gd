extends Node2D

const ROCKET_SCENE = preload("res://Scenes/rocket.tscn")
const ENEMY_SCENE = preload("res://Scenes/enemy.tscn")
const MOTHERSHIP_SCENE = preload("res://Scenes/mother_ship.tscn")
const OCTOPUS_1 = preload("res://Assets/Invaders/Octopus-1.png")
const SQUID_1 = preload("res://Assets/Invaders/Squid-1.png")
const CRAB_1 = preload("res://Assets/Invaders/Crab-1.png")

@onready var hud: CanvasLayer = $HUD
@onready var enemy_shot_timer: Timer = $EnemyShotTimer
@onready var player: Area2D = $Player
@onready var player_respawn_timer: Timer = $PlayerRespawnTimer
@onready var mother_ship_timer: Timer = $MotherShipTimer

const ROWS = 5
const COLS = 10
const START_X = 100
const START_Y = 110
const WIDTH = 70
const HEIGHT = 50

var screen_size
var lives = 3
var score = 0
var game_over = false

func _ready():
	screen_size = get_viewport_rect().size
	hud.hide_message()
	for i in range(ROWS):
		for j in range(COLS):
			var enemy = ENEMY_SCENE.instantiate() as Area2D
			if i == 0:
				enemy.get_child(0).texture = SQUID_1
				enemy.get_child(1).current_animation = 'squid_movement'
				enemy.name = 'Squid' + str(i) + str(j)
				enemy.global_position = Vector2(START_X + 95 + 50 * j, START_Y + HEIGHT * i)
				enemy.score = 40
				enemy.width = 50
				enemy.width_offset = 100
			elif i == 1 || i == 2:
				enemy.get_child(0).texture = CRAB_1
				enemy.get_child(1).current_animation = 'crab_movement'
				enemy.name = 'Crab' + str(i - 1) + str(j)
				enemy.global_position = Vector2(START_X + 45 + 60 * j, START_Y + HEIGHT * i)
				enemy.score = 30
				enemy.width = 60
				enemy.width_offset = 50
			else:
				enemy.get_child(0).texture = OCTOPUS_1
				enemy.get_child(1).current_animation = 'octopus_movement'
				enemy.name = 'Octopus' + str(i - 3) + str(j)
				enemy.global_position = Vector2(START_X + WIDTH * j, START_Y + HEIGHT * i)
				enemy.width = 70
				enemy.score = 20
			enemy.scale = Vector2(4, 4)
			enemy.column_n = j
			enemy.killed.connect(_on_enemy_killed)
			enemy.reached_bottom.connect(trigger_game_over)
			add_child(enemy)

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()

func _on_enemy_killed(enemy_score):
	score += enemy_score
	hud.update_score(score)
	if get_children().filter(func (e): if e is Enemy: return true).size() == 1:
		mother_ship_timer.stop()
		hud.show_message(score)

func _on_player_killed(dead) -> void:
	if dead:
		trigger_game_over()

	lives -= 1
	hud.update_lives(lives)
	score -= 100
	hud.update_score(score)
	player_respawn_timer.start()
	player.hide()
	if lives == 0:
		trigger_game_over()

func trigger_game_over():
	game_over = true
	player.game_over = true
	hud.show_message()
	enemy_shot_timer.stop()
	for e in get_children().filter(func (e): if e is Enemy: return true):
		e.game_over = true

func _on_player_respawn_timer_timeout() -> void:
	if !game_over:
		player.show()

func _on_mother_ship_timer_timeout() -> void:
	var mother_ship = MOTHERSHIP_SCENE.instantiate() as Area2D
	mother_ship.global_position = Vector2(screen_size.x + 40, 60)
	mother_ship.scale = Vector2(4, 4)
	mother_ship.killed.connect(_on_enemy_killed)
	add_child(mother_ship)

func _on_enemy_shot_timer_timeout() -> void:
	var random_enemy_position = get_children().filter(func (e): if e is Enemy: return true).map(func (e): return e.global_position).pick_random()
	var rocket = ROCKET_SCENE.instantiate() as Area2D
	if random_enemy_position:
		rocket.global_position = random_enemy_position + Vector2(0, 20)
		add_child(rocket)
