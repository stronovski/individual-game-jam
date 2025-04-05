extends Node2D

@export var letter: String = "a"

@onready var default_label_position = $Label.position
@onready var default_button_position = $AnimatedSprite2D.position
@export var pressed_button_offset = Vector2(0, 5)
@export var pressed_label_offset = Vector2(0, 16)

func _ready() -> void:
	if letter == "space":
		$Label.text = ""
		$AnimatedSprite2D.frame = 3
	elif letter == "unclickable":
		$Label.text = ""
		$AnimatedSprite2D.frame = 2
	else:
		$AnimatedSprite2D.frame = 0
		$Label.text = letter.to_upper()

func _input(event):
	if letter == "space":
		if event.is_action_pressed("ui_accept"):
			_press_button()
		elif event.is_action_released("ui_accept"):
			_release_button()
	else:
		if event.is_action_pressed(letter.to_lower()):
			_press_button()
		elif event.is_action_released(letter.to_lower()):
			_release_button()
		
func _press_button():
	var tween = create_tween()
	if letter == "space":
		tween.tween_property($AnimatedSprite2D, "frame", 4, 0.05)
		tween.parallel().tween_property($AnimatedSprite2D, "position", 
									  default_button_position + pressed_button_offset, 
									  0.04)
	else:
		tween.tween_property($AnimatedSprite2D, "frame", 1, 0.05)
		tween.parallel().tween_property($AnimatedSprite2D, "position", 
									  default_button_position + pressed_button_offset, 
									  0.04)
		tween.parallel().tween_property($Label, "position", 
									  default_label_position + pressed_label_offset, 
									  0.04)
									
func _release_button():
	if letter == "space":
		$AnimatedSprite2D.position = default_button_position
		$AnimatedSprite2D.frame = 3
	else:
		$AnimatedSprite2D.position = default_button_position
		$Label.position = default_label_position
		$AnimatedSprite2D.frame = 0
