extends AnimatedSprite2D


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
		frame = 1
	elif event.is_action_released(str(expected_input)) or \
		event.is_action_released("ui_accept"):
		$PushTimer.start()


func _handle_hit():
	if perfect:
		get_parent().increment_score(3)
		current_note.destroy(3)
	elif good:
		get_parent().increment_score(2)
		current_note.destroy(2)
	elif okay:
		get_parent().increment_score(1)
		current_note.destroy(1)
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
		current_note = null


func _on_PushTimer_timeout():
	frame = 0


func _reset():
	current_note = null
	perfect = false
	good = false
	okay = false
