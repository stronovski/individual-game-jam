extends Node2D

var prologue = "res://Scenes/Prologue.tscn"

func _on_play_pressed() -> void:
	$ClickButtonSound.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file(prologue)


func _on_exit_pressed() -> void:
	$ClickButtonSound.play()
	get_tree().quit()
