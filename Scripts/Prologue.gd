extends Node2D

@export var dialogue_start: String = "start"
@export var resource_path: String = "res://Dialogues/dialogue.dialogue"
@export var next_scene_path = "res://Scenes/LevelSelect.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var resource: DialogueResource = load(resource_path)
	DialogueManager.connect("dialogue_ended", _on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(resource, "start")

func _on_dialogue_ended(_args=[]):
	if ResourceLoader.exists(next_scene_path):
		get_tree().change_scene_to_file(next_scene_path)
	else:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
