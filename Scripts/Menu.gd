extends Node2D
#
### The star scene to spawn
#@export var star_scene: PackedScene
#
### Spawning behavior
#@export_group("Spawning")
#@export var min_stars: int = 2
#@export var max_stars: int = 3
#@export var spawn_interval: float = 1.5
#@export var burst_delay: float = 0.2
#
### Star appearance
#@export_group("Appearance")
#@export var min_scale: float = 0.5
#@export var max_scale: float = 1.2
#@export var rotation_variation: float = 1.0
#@export var fade_time: float = 0.5
#
### Movement
#@export_group("Movement")
#@export var can_move: bool = true
#@export var move_distance: float = 50.0
#@export var move_speed: float = 0.5
#
## Viewport dimensions
#var viewport_size := Vector2(1920, 1080)
#var margin := Vector2(100, 100)  # Prevent spawning too close to edges
#
#func _ready():
	## Get actual viewport size if different from design resolution
	#viewport_size = get_viewport().get_visible_rect().size
	#
	## Load default scene if not set
	#if star_scene == null:
		#star_scene = preload("res://Scenes/Star.tscn")
	#
	## Start spawning
	#_start_spawning()
#
#func _start_spawning():
	#while true:
		#var star_count = randi_range(min_stars, max_stars)
		#for i in star_count:
			#spawn_star()
			#await get_tree().create_timer(randf_range(burst_delay * 0.5, burst_delay)).timeout
		#await get_tree().create_timer(spawn_interval).timeout
#
#func spawn_star():
	#var star = star_scene.instantiate()
	#add_child(star)
	#
	## Random position within safe area (viewport size minus margins)
	#var spawn_rect := Rect2(
		#margin.x,
		#margin.y,
		#viewport_size.x - margin.x * 2,
		#viewport_size.y - margin.y * 2
	#)
	#
	#star.position = Vector2(
		#randf_range(spawn_rect.position.x, spawn_rect.end.x),
		#randf_range(spawn_rect.position.y, spawn_rect.end.y)
	#)
	#
	## Random appearance
	#star.scale = Vector2.ONE * randf_range(min_scale, max_scale)
	#star.rotation = randf_range(-PI * rotation_variation, PI * rotation_variation)
	#
	## Initial fade in
	#star.modulate.a = 0
	#var tween = create_tween()
	#tween.tween_property(star, "modulate:a", 1.0, fade_time)
	#
	## Optional movement (clamped to viewport)
	#if can_move:
		#var move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		#var target_pos = star.position + (move_direction * move_distance)
		#
		## Clamp target position to viewport
		#target_pos.x = clamp(target_pos.x, 0, viewport_size.x)
		#target_pos.y = clamp(target_pos.y, 0, viewport_size.y)
		#
		#tween = create_tween()
		#tween.tween_property(star, "position", target_pos, move_speed)\
			#.set_ease(Tween.EASE_IN_OUT)
#
## Debug drawing to visualize spawn area (enable in _draw)
#func _draw():
	#if Engine.is_editor_hint():
		#var spawn_rect := Rect2(
			#margin.x,
			#margin.y,
			#viewport_size.x - margin.x * 2,
			#viewport_size.y - margin.y * 2
		#)
		#draw_rect(spawn_rect, Color(0, 1, 0, 0.2), true)
