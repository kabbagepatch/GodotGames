extends Node2D

@onready var ball: StaticBody2D = $Ball
var recent_player_loss = 1

func on_p1_hit():
	ball.velocity.x = 1

func on_p2_hit():
	ball.velocity.x = -1

func edge_hit(player):
	ball.reset(1 if player == 1 else -1)
