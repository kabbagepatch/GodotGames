extends Area2D
class_name Enemy
signal killed(score)
signal reached_bottom

const ROCKET_SCENE = preload("res://Scenes/rocket.tscn")

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var movement_timer: Timer = $MovementTimer
@onready var sprite_2d: Sprite2D = $Sprite2D

var rng = RandomNumberGenerator.new()
const ROWS = 5
const COLS = 10

@export var speed = 400
@export var column_n = 0
@export var width = 70
@export var width_offset = 0
@export var height = 50
@export var score = 0
@export var game_over = 0
var can_shoot = true

var screen_size
var x_limit = 10
var direction = 'R'
var go_down = false
var gone_down = false

func _ready():
	screen_size = get_viewport_rect().size
	movement_timer.timeout.connect(move_invaders)

func move_invaders():
	if game_over: return

	if position.x > screen_size.x  - (COLS - column_n) * width + width / 2 - width_offset && !gone_down:
		direction = 'L'
		go_down = true
	if position.x < column_n * width + width / 2 + width_offset - 5 && !gone_down:
		direction = 'R'
		go_down = true

	if go_down:
		position.y += 20
		go_down = false
		gone_down = true
	else:
		gone_down = false
		if direction == 'R':
			position.x += 10
		else:
			position.x -= 10

	if position.y > screen_size.y - 60:
		reached_bottom.emit()

func _on_area_entered(area: Area2D) -> void:
	if area is Laser:
		emit_signal("killed", score);
		animation_player.play('destroy')
		area.queue_free()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'destroy':
		queue_free()
