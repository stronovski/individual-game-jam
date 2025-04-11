extends Node2D

var perfect = false
var good = false
var okay = false
var current_note = null

@export var lane_type = "combined" # number, "letter, or "space


func _unhandled_input(event):
	var expected_input = ""
	if current_note != null:
		print("Note exists! Type: ", lane_type, " | Value: ", current_note.note_value)
		expected_input = current_note.note_value
		if lane_type == "combined" and event.is_action_pressed(str(expected_input).to_lower()):
			_handle_hit()
		elif lane_type == "space" and event.is_action_pressed("ui_accept"):
			_handle_hit()
			
	# Visual feedback
	if (lane_type == "combined" and event.is_action_pressed(str(expected_input).to_lower())) or \
		(lane_type == "space" and event.is_action_pressed("ui_accept")):
		$AnimatedSprite2D.frame = 1
	elif event.is_action_released(str(expected_input)) or \
		event.is_action_released("ui_accept"):
			$PushTimer.start()


func _handle_hit():
	var score_value = 0
	if perfect:
		score_value = 3
	elif good:
		score_value = 2
	elif okay:
		score_value = 1
		
	if score_value > 0:
		get_parent().increment_score(score_value)
		current_note.destroy(score_value)
	
	_reset()


func _on_PerfectArea_area_entered(area):
	if area.is_in_group("note"):
		perfect = true
		current_note = area


func _on_PerfectArea_area_exited(area):
	if area.is_in_group("note"):
		perfect = false


func _on_GoodArea_area_entered(area):
	if area.is_in_group("note"):
		good = true
		current_note = area


func _on_GoodArea_area_exited(area):
	if area.is_in_group("note"):
		good = false


func _on_OkayArea_area_entered(area):
	if area.is_in_group("note"):
		okay = true
		current_note = area


func _on_OkayArea_area_exited(area):
	if area.is_in_group("note"):
		okay = false
		#current_note = null
		if current_note == area:
			area.start_falling_behind()
			get_parent().emit_missed()
			get_parent().show_feedback(0)


func _on_PushTimer_timeout():
	$AnimatedSprite2D.frame = 0


func _reset():
	current_note = null
	perfect = false
	good = false
	okay = false
	
