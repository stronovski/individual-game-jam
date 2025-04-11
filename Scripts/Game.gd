extends Node2D

var score = 0
var combo = 0

var max_combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0

var bpm = 85

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm

var spawn_1_beat = 0
var spawn_2_beat = 0
var spawn_3_beat = 1
var spawn_4_beat = 0

var lane = 0
var rand = 0
var note = load("res://Scenes/Note.tscn")
var instance

var feedback_duration = 0.3

var full_text = ""

var current_char_index = 0

@onready var feedback_label = $CanvasLayer/FeedbackLabel

func _ready():
	print("Game BPM: ", bpm)
	randomize()
	$Conductor.play_with_beat_offset(8)
	
	Global.beat.connect(_on_Conductor_beat)
	Global.measure_signal.connect(_on_Conductor_measure)
	
	feedback_label.visible = false

func _input(event):
	if event.is_action("escape"):
		if get_tree().change_scene_to_file("res://Scenes/Menu.tscn") != OK:
			print ("Error changing scene to Menu")

func _on_Conductor_measure(position):
	if position == 1:
		_spawn_notes(spawn_1_beat)
	elif position == 2:
		_spawn_notes(spawn_2_beat)
	elif position == 3:
		_spawn_notes(spawn_3_beat)
	elif position == 4:
		_spawn_notes(spawn_4_beat)

func _on_Conductor_beat(position):
	song_position_in_beats = position
	if song_position_in_beats > 36:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 98:
		spawn_1_beat = 2
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats > 132:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 0
		spawn_4_beat = 2
	if song_position_in_beats > 162:
		spawn_1_beat = 2
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 194:
		spawn_1_beat = 2
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 228:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 258:
		spawn_1_beat = 1
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 288:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 0
		spawn_4_beat = 2
	if song_position_in_beats > 322:
		spawn_1_beat = 3
		spawn_2_beat = 2
		spawn_3_beat = 2
		spawn_4_beat = 1
	if song_position_in_beats > 388:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	if song_position_in_beats > 396:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	if song_position_in_beats > 404:
		Global.set_score(score)
		Global.combo = max_combo
		Global.great = great
		Global.good = good
		Global.okay = okay
		Global.missed = missed
		
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		if get_tree().change_scene_to_file("res://Scenes/End.tscn") != OK:
			print ("Error changing scene to End")

func _spawn_notes(to_spawn):
	print("Attempting to spawn ", to_spawn, " notes")
	if to_spawn > 0:
		lane = randi() % 2
		var note_value = spawn_note_lane(lane)

		instance = note.instantiate()
		if instance:
			instance.initialize(lane, note_value)
			add_child(instance)
			print("Spawned note with value: ", note_value)
		else:
			print("Failed to instantiate note")
				
	if to_spawn > 1:
		while rand == lane:
			rand = randi() % 2
		lane = rand
		var note_value = spawn_note_lane(lane)
		print("Spawning second note in lane: ", lane)
		instance = note.instantiate()
		if instance:
			instance.initialize(lane, note_value)
			add_child(instance)
			print("Spawned note with value: ", note_value)
	
func show_feedback(score):
	if $FeedbackTimer.time_left > 0:
		$FeedbackTimer.stop()
		
	match score:
		3:
			feedback_label.text = "GREAT"
			feedback_label.modulate = Color("f6d6bd")
			#$GreatSound.play()
		2:
			feedback_label.text = "GOOD"
			feedback_label.modulate = Color("c3a38a")
			#$GoodSound.play()
		1:
			feedback_label.text = "OKAY"
			feedback_label.modulate = Color("997577")
			#$OkaySound.play()
		0:
			feedback_label.text = "MISS"
			feedback_label.modulate = Color("ff0000")
			#$MissSound.play()
		
	feedback_label.visible = true
	feedback_label.scale = Vector2(1.2, 1.2)
	var tween = create_tween()
	tween.tween_property(feedback_label, "scale", Vector2(1,1), 0.1)
	
	$FeedbackTimer.wait_time = feedback_duration
	$FeedbackTimer.start()
	
func emit_missed():
	increment_score(0)

func increment_score(by):
	if by > 0:
		combo += 1
	else:
		combo = 0
	
	if by == 3:
		great += 1
	elif by == 2:
		good += 1
	elif by == 1:
		okay += 1
	else:
		missed += 1
	
	score += by * combo
	$CanvasLayer/ScoreLabel.text = str(score)
	if combo > 0:
		$CanvasLayer/Combo.text = str(combo)
		if combo > max_combo:
			max_combo = combo
	else:
		$CanvasLayer/Combo.text = ""


func reset_combo():
	combo = 0
	$CanvasLayer/Combo.text = ""
	
	
func spawn_note_lane(lane: int) -> String:
	var note_value: String
	
	if lane == 0:
		if randi() % 2 == 0:
			note_value = str(randi() % 10).to_upper()
		else:
			note_value = char(97 + randi() % 26).to_upper()
	else:
		note_value = "space"
	print("Spawning note in lane: ", lane, " with value: ", note_value)
	return note_value
