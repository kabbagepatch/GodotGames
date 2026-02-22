extends Node2D

const ROCKET_SCENE = preload("res://Scenes/rocket.tscn")
const ENEMY_SCENE = preload("res://Scenes/enemy.tscn")
const OCTOPUS_1 = preload("res://Assets/Invaders/Octopus-1.png")
const SQUID_1 = preload("res://Assets/Invaders/Squid-1.png")
const CRAB_1 = preload("res://Assets/Invaders/Crab-1.png")

@onready var hud: CanvasLayer = $HUD
@onready var enemy_shot_timer: Timer = $EnemyShotTimer

const ROWS = 5
const COLS = 10

var game_over = false
var enemies = []

func _ready():
	hud.hide()
	enemy_shot_timer.timeout.connect(enemy_shoot)
	var world_node = get_tree().root.get_node("World")
	for i in range(ROWS):
		for j in range(COLS):
			var enemy = ENEMY_SCENE.instantiate() as Area2D
			if i == 0:
				enemy.get_child(0).texture = SQUID_1
				enemy.name = 'Squid' + str(i) + str(j)
			elif i == 1 || i == 2:
				enemy.get_child(0).texture = CRAB_1
				enemy.name = 'Crab' + str(i - 1) + str(j)
			else:
				enemy.get_child(0).texture = OCTOPUS_1
				enemy.name = 'Octopus' + str(i - 3) + str(j)
			enemy.global_position = Vector2(100 + 70 * j, 100 + 50 * i)
			enemy.scale = Vector2(4, 4)
			enemy.column_n = j
			enemies.push_back(enemy)
			world_node.add_child(enemy)

func enemy_shoot():
	var world_node = get_tree().root.get_node("World")
	var random_enemy_position = enemies.filter(func (e): if e: return true).map(func (e): return e.global_position).pick_random()
	var rocket = ROCKET_SCENE.instantiate() as Area2D
	if random_enemy_position:
		rocket.global_position = random_enemy_position + Vector2(0, 20)
		world_node.add_child(rocket)
