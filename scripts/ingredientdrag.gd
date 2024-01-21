extends Node2D

@export var ingredient = "Ingredient name"

var selected = true
var rest_point
var should_delete = false  # Flag to indicate whether the node should be deleted
var blender
var shortest_dist = 75

@export var size = ""
@export var type = 0

func _ready():
	rest_point = get_parent().global_position
	blender = get_tree().get_root().get_node("SceneManager/World/blender")

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if (Input.is_action_just_pressed("click")):
		selected = true
	if (Input.is_action_just_released("click")):
		selected = false
		var distance = global_position.distance_to(blender.global_position)
		if (distance < shortest_dist):
			rest_point = blender.global_position
			shortest_dist = distance
			blender.append(ingredient)
			queue_free()

		else:
			should_delete = true  # Set the flag to delete the node

func _physics_process(delta):
	if (selected):
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		look_at(get_global_mouse_position())
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)
		rotation = lerp_angle(rotation, 0, 10 * delta)

		# Check if the node has reached the rest point and should be deleted
		if should_delete and global_position.distance_to(rest_point) < 5:
			queue_free()
			
func setData(dSize, dType):
	size = dSize
	type = dType
