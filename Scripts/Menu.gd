extends Node2D

@onready var transition = $Transition
var prologue = "res://scenes/Prologue.tscn"

func _on_play_pressed() -> void:
	$AudioStreamPlayer2D.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file(prologue)
