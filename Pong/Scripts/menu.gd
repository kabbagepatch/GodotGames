extends Control
@onready var start: Button = $VBoxContainer/Start

signal start_game

func _ready() -> void:
	start.grab_focus()

func _on_start_pressed() -> void:
	print('Start Test')
	start_game.emit()

func _on_quit_pressed() -> void:
	get_tree().quit()
