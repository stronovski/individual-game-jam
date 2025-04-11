extends Area2D

const TARGET_X = 70
const SPAWN_X = 300
const DIST_TO_TARGET = abs(TARGET_X - SPAWN_X)

const LEFT_LANE_SPAWN = Vector2(SPAWN_X, 30) # Numbers + letters lane (top)
const RIGHT_LANE_SPAWN = Vector2(SPAWN_X, 60) # Space lane (bottom)

var speed = 0
var hit = false
@export var note_value = ""

var falling_behind := false
@onready var original_z_index = z_index

#@onready var feedback_label = $Node2D/FeedbackLabel

func _ready():
	pass


func _physics_process(delta):
	if !hit:
		position.x -= speed * delta
		if position.x < 0:
			if !hit:
				if get_parent().has_method("reset_combo"):
					#get_parent().emit_missed()
					#get_parent().show_feedback(0)
					get_parent().reset_combo()
			queue_free()
	else:
		$Node2D.position.x -= speed * delta


func initialize(lane, value = ""):
	if lane == 0:
		position = LEFT_LANE_SPAWN
		note_value = value
		$Node2D/NoteLabel.text = note_value
		$Node2D/NoteLabel.modulate = Color("363636")
	elif lane == 1:
		position = RIGHT_LANE_SPAWN
		note_value = value
		$Node2D/NoteLabel.text = note_value
		$Node2D/NoteLabel.modulate = Color("363636")
	else:
		printerr("Invalid lane set for note: " + str(lane))
		return

	speed = DIST_TO_TARGET / 2.0


func destroy(score):
	$CPUParticles2D.emitting = true
	$Node2D/NoteLabel.visible = false
	$Timer.start()
	hit = true
	get_parent().show_feedback(score)

func _on_Timer_timeout():
	queue_free()
	
func start_falling_behind():
	falling_behind = true
	z_index = -1
