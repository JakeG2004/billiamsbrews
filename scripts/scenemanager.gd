extends Node2D

var currentScene

@onready var menu = preload("res://scenes/menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	loadLevel("menu")
	
func reload():
	loadLevel(currentScene)
	
	
func loadLevel(levelName):
	currentScene = levelName

	# If no level exists, don't try to delete the current level
	if get_child_count() > 0:
		get_child(0).queue_free()

	# Create level, set its name (for future reference), then add it to the sceneManager node
	# Use call deferred to do it in next idle frame. It does something with avoiding conflict in the main thread
	match levelName:
		"quit":
			get_tree().quit()
			return
		"menu":
			call_deferred("add_child", menu.instantiate())
