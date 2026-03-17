extends Control

signal start_game
@onready var main_menu: VBoxContainer = $MainMenu
@onready var new_game: Button = $MainMenu/NewGame
@onready var high_score_container: PanelContainer = $HighScoreContainer
@onready var high_scores: VBoxContainer = $HighScoreContainer/HighScores
@onready var back: Button = $Back

func _ready() -> void:
	new_game.grab_focus()
	high_score_container.hide()
	back.hide()
	populate_highscores()

func _on_new_game_pressed() -> void:
	start_game.emit()

func _on_high_scores_pressed() -> void:
	high_score_container.show()
	back.show()
	main_menu.hide()

func _on_quit_pressed() -> void:
	get_tree().quit()

func populate_highscores() -> void:
	var scores = Highscores.load_high_scores()
	for i in scores.size():
		var entry_container = MarginContainer.new()
		entry_container.name = 'Highscore Container %d' % i
		entry_container.add_theme_constant_override("margin_top", 10)
		entry_container.add_theme_constant_override("margin_left", 10)
		entry_container.add_theme_constant_override("margin_right", 10)
		high_scores.add_child(entry_container)
		var entry = HBoxContainer.new()
		entry.name = 'Highscore %d' % i
		entry.alignment = BoxContainer.ALIGNMENT_CENTER
		entry_container.add_child(entry)
		var dt_label = Label.new()
		dt_label.name = 'Highscore %d Date' % i
		dt_label.text = "#%d  %s" % [(i + 1), scores[i]["datetime"]]
		dt_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		var score_label = Label.new()
		score_label.name = 'Highscore %d Score' % i
		score_label.text = "%s" % scores[i]["score"]
		score_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		var labels = [dt_label, score_label]
		for l in labels:
			l.add_theme_font_size_override("font_size", 18)
			l.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			entry.add_child(l)

func _on_back_pressed() -> void:
	high_score_container.hide()
	back.hide()
	main_menu.show()
