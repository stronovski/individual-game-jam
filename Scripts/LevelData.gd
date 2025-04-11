# LevelData.gd
class_name LevelData
extends Resource

@export var song: AudioStream
@export var bpm: int = 100
@export var level_name: String = "Level 1"
@export var spawn_pattern: Dictionary = {
	# Format: {beat_number: [lane0_notes, lane1_notes]}
	1: [1, 0],  # On beat 1: spawn 1 note in lane 0, 0 in lane 1
	2: [0, 1],  # On beat 2: spawn 0 in lane 0, 1 in lane 1
	# Add more beat patterns as needed
}
