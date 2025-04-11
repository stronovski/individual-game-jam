extends Node2D

var epilogue = "res://scenes/Epilogue.tscn"
var menu = "res://scenes/Menu.tscn"


func _ready():
	$GradeNumber.text = Global.grade
	$ScoreNumber.text = str(Global.score)
	$ComboNumber.text = str(Global.combo)
	$GreatNumber.text = str(Global.great)
	$GoodNumber.text = str(Global.good)
	$OkayNumber.text = str(Global.okay)
	$MissedNumber.text = str(Global.missed)
	

func _on_PlayAgain_pressed():
	if get_tree().change_scene_to_file("res://Scenes/Game.tscn") != OK:
			print ("Error changing scene to Game")


func _on_BackToMenu_pressed():
	if get_tree().change_scene_to_file("res://Scenes/Menu.tscn") != OK:
			print ("Error changing scene to Menu")


func _on_continue_button_pressed() -> void:
	$AudioStreamPlayer2D.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file(epilogue)


func _on_main_menu_button_pressed() -> void:
	$AudioStreamPlayer2D.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file(menu)
