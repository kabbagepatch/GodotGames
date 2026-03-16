extends Control

signal start_game
@onready var new_game: Button = $MainMenu/NewGame

func _ready() -> void:
	new_game.grab_focus()

func _on_new_game_pressed() -> void:
	start_game.emit()

func _on_quit_pressed() -> void:
	get_tree().quit()
