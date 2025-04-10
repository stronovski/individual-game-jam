extends Sprite2D

@export var lifetime: float = 2.0
@export var fade_time: float = 0.5

func _ready():
	# Start lifetime countdown
	await get_tree().create_timer(lifetime).timeout
	
	# Fade out and remove
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, fade_time)
	await tween.finished
	queue_free()
