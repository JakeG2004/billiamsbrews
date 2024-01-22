extends Node2D

var selected = false
var rest_point
var rest_nodes = []
@export var size = "none"
@export var type = 0

var play_card
var exit_card
var credits_card
var music_card

@onready var sm = get_tree().get_root().get_node("SceneManager")

func _ready():
	rest_nodes = get_tree().get_nodes_in_group("potzone")
	rest_point = global_position
	sm.loadLevel("level1")

	# Assuming you have nodes named "play_card", "exit_card", "credits_card", and "music_card"
	play_card = get_parent().get_node("play")
	exit_card = get_parent().get_node("exit")
	credits_card = get_parent().get_node("credits")
	music_card = get_parent().get_node("music")

func _on_area2D_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true
	if Input.is_action_just_released("click"):
		selected = false
		var shortest_dist = 75
		var closest_card = null

		for child in rest_nodes:
			var distance = global_position.distance_to(child.global_position)
			if distance < shortest_dist:
				shortest_dist = distance
				closest_card = child

		if closest_card:
			handle_potion_placement(closest_card)

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)

func handle_potion_placement(card):
	if card == play_card:
		print("Potion placed on Play Card")
	elif card == exit_card:
		print("Potion placed on Exit Card")
	elif card == credits_card:
		print("Potion placed on Credits Card")
	elif card == music_card:
		print("Potion placed on Music Card")
	else:
		print("Potion placed on a different card")
