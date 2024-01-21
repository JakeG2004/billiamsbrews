extends Node2D

@export var path = "Path to Draggable"

@onready var draggable = load(path)

var click_processed = false  # Flag to track whether the click has been processed

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if(Input.is_action_just_pressed("click") and not click_processed):
		var instanced_scene = draggable.instantiate()
		add_child(instanced_scene)
		click_processed = true
		
func _input(event):
	if(Input.is_action_just_released("click")):
		click_processed = false
