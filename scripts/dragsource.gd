extends Node2D

@export var path = "Path to Draggable"

@onready var draggable = load(path)

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if(Input.is_action_just_pressed("click")):
		var instanced_scene = draggable.instantiate()
		add_child(instanced_scene)
