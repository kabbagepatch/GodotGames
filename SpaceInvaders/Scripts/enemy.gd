extends Area2D

@onready var movement_timer: Timer = $MovementTimer

var rng = RandomNumberGenerator.new()

@export var speed = 400
var screen_size
var x_limit = 10

func _ready():
	screen_size = get_viewport_rect().size
	movement_timer.timeout.connect(move_invaders)

func move_invaders():
	position.x += 10

func _on_area_entered(area: Area2D) -> void:
	if area is Laser:
		area.queue_free()
		queue_free()
