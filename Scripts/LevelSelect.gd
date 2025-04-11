extends Node2D
#
var game = "res://Scenes/Game.tscn"

func _on_write_button_pressed() -> void:
	$AudioStreamPlayer2D.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file(game)
	 
