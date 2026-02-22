extends Node

const LASER_SCENE = preload("res://Scenes/laser.tscn")

var can_shoot = true
func _process(delta):
	if Input.is_action_pressed("shoot") and can_shoot:
		can_shoot = false
		var laser = LASER_SCENE.instantiate() as Area2D
		laser.global_position = get_parent().global_position - Vector2(0, 20)
		get_tree().root.get_node("World").add_child(laser)
		laser.tree_exited.connect(on_laser_destroyed)

func on_laser_destroyed():
	can_shoot = true
