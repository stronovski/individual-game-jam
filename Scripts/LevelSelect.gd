extends Node2D
#
var game = "res://Scenes/Game.tscn"
var bpm = Global.get_bpm()

@onready var bpm_input = $BPMInput

#func _ready():
	#bpm_input.text = Global.get_bpm()

func _on_write_button_pressed() -> void:
	var new_bpm = int(bpm_input.text)
	Global.set_bpm(new_bpm)
	
	$AudioStreamPlayer2D.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file(game)
	 
