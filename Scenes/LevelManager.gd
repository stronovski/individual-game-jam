# LevelManager.gd
class_name LevelManager
extends Node

static var available_levels: Array[LevelData] = []
static var current_level: LevelData = null

static func load_levels():
	var dir = DirAccess.open("res://Levels/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"):
				var level = load("res://Levels/%s" % file_name)
				available_levels.append(level)
			file_name = dir.get_next()
