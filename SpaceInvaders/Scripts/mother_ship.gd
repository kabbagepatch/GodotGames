extends Area2D
signal killed(score)

const ROCKET_SCENE = preload("res://Scenes/rocket.tscn")

var speed = 200

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	velocity.x -= 1
	velocity = velocity.normalized() * speed
	position += velocity * delta
	if position.x < -20:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is Laser:
		emit_signal("killed", 100);
		area.queue_free()
		queue_free()

func _on_mother_ship_shot_timer_timeout() -> void:
	var rocket = ROCKET_SCENE.instantiate() as Area2D
	rocket.global_position = position + Vector2(0, 20)
	add_sibling(rocket)
