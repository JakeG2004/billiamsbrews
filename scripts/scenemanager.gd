extends Node2D

var currentScene

@onready var menu = preload("res://scenes/menu.tscn")
@onready var music = preload("res://scenes/music.tscn")
@onready var credits = preload("res://scenes/credits.tscn")
@onready var levels = preload("res://scenes/levels.tscn")
@onready var tutorial = preload("res://scenes/tutorial.tscn")
@onready var level1 = preload("res://scenes/level1.tscn")
@onready var level2 = preload("res://scenes/level2.tscn")
@onready var level3 = preload("res://scenes/level3.tscn")
@onready var level4 = preload("res://scenes/level4.tscn")
@onready var level5 = preload("res://scenes/level5.tscn")

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
		
	await get_tree().create_timer(.1).timeout

	# Create level, set its name (for future reference), then add it to the sceneManager node
	# Use call deferred to do it in next idle frame. It does something with avoiding conflict in the main thread
	match levelName:
		"quit":
			get_tree().quit()
			return
		"menu":
			call_deferred("add_child", menu.instantiate())
		"music":
			call_deferred("add_child", music.instantiate())
		"credits":
			call_deferred("add_child", credits.instantiate())
		"levels":
			call_deferred("add_child", levels.instantiate())
		"tutorial":
			call_deferred("add_child", tutorial.instantiate())
		"level1":
			call_deferred("add_child", level1.instantiate())
		"level2":
			call_deferred("add_child", level2.instantiate())
		"level3":
			call_deferred("add_child", level3.instantiate())
		"level4":
			call_deferred("add_child", level4.instantiate())
		"level5":
			call_deferred("add_child", level5.instantiate())
