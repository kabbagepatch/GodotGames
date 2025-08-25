extends Control
@onready var human: Button = $MainMenu/Human
@onready var main_menu: VBoxContainer = $MainMenu
@onready var sub_menu: VBoxContainer = $SubMenu
@onready var easy: Button = $SubMenu/Easy

signal start_game

func _ready() -> void:
	human.grab_focus()

func _on_human_pressed() -> void:
	start_game.emit("HUMAN")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_computer_pressed() -> void:
	sub_menu.show()
	easy.grab_focus()
	main_menu.hide()

func _on_easy_pressed() -> void:
	start_game.emit("EASY")

func _on_medium_pressed() -> void:
	start_game.emit("MEDIUM")

func _on_hard_pressed() -> void:
	start_game.emit("HARD")
