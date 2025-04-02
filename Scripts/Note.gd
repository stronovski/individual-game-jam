extends Area2D

const TARGET_X = 70
const SPAWN_X = 300
const DIST_TO_TARGET = abs(TARGET_X - SPAWN_X)

const LEFT_LANE_SPAWN = Vector2(SPAWN_X, 20) # Numbers + letters lane (top)
const RIGHT_LANE_SPAWN = Vector2(SPAWN_X, 60) # Space lane (bottom)

var speed = 0
var hit = false
@export var note_value = ""

@onready var feedback_label = $Node2D/FeedbackLabel

func _ready():
	pass


func _physics_process(delta):
	if !hit:
		position.x -= speed * delta
		if position.x < 0:
			queue_free()
			get_parent().reset_combo()
	else:
		$Node2D.position.x -= speed * delta


func initialize(lane, value = ""):
	if lane == 0:
		position = LEFT_LANE_SPAWN
		note_value = value
		$Node2D/NoteLabel.text = note_value
		#note_label.modulate = Color("f6d6bd")
	elif lane == 1:
		position = RIGHT_LANE_SPAWN
		note_value = value
		$Node2D/NoteLabel.text = note_value
		#note_label.modulate = Color("f6d6bd")
	else:
		printerr("Invalid lane set for note: " + str(lane))
		return

	speed = DIST_TO_TARGET / 2.0


func destroy(score):
	$CPUParticles2D.emitting = true
	$Node2D/NoteLabel.visible = false
	$Timer.start()
	hit = true
	if score == 3:
		feedback_label.text = "GREAT"
		feedback_label.modulate = Color("f6d6bd")
	elif score == 2:
		feedback_label.text = "GOOD"
		feedback_label.modulate = Color("c3a38a")
	elif score == 1:
		feedback_label.text = "OKAY"
		feedback_label.modulate = Color("997577")

func _on_Timer_timeout():
	queue_free()
