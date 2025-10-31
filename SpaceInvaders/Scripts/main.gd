extends Node2D

const ENEMY_SCENE = preload("res://Scenes/enemy.tscn")
const OCTOPUS_1 = preload("res://Assets/Invaders/Octopus-1.png")
const SQUID_1 = preload("res://Assets/Invaders/Squid-1.png")
const CRAB_1 = preload("res://Assets/Invaders/Crab-1.png")

const ROWS = 5
const COLS = 10

func _ready():
	var world_node = get_tree().root.get_node("World")
	for i in range(ROWS):
		for j in range(COLS):
			var enemy = ENEMY_SCENE.instantiate() as Area2D
			if i == 0:
				enemy.get_child(0).texture = SQUID_1
			elif i == 1 || i == 2:
				enemy.get_child(0).texture = CRAB_1
			else:
				enemy.get_child(0).texture = OCTOPUS_1
			enemy.global_position = Vector2(100 + 70 * j, 100 + 50 * i)
			enemy.scale = Vector2(4, 4)
			world_node.add_child(enemy)
