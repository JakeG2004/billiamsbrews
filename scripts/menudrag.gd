extends Node2D

var selected = false
var rest_point
var rest_nodes = []

var play_card
var music_card
var credits_card
var exit_card

var click_processed = false

func _ready():
	rest_nodes = get_tree().get_nodes_in_group("potzone")
	rest_point = global_position

	# Assuming you have nodes named "SuccessCard" and "FailureCard"
	play_card = get_parent().get_node("play")
	music_card = get_parent().get_node("music")
	credits_card = get_parent().get_node("credits")
	exit_card = get_parent().get_node("exit")

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
				rest_point = child.global_position
				closest_card = child

		if closest_card && !click_processed:
			handle_potion_placement(closest_card)
			click_processed = true

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)

func handle_potion_placement(card):
	if card == play_card:
		# Handle success card logic here
		print("Play")
		
	if card == exit_card:
		print("Exit")
		# Handle failure card logic here
	
	# Reset click_processed to allow for the next placement
	click_processed = false

func _input(_event):
	if(Input.is_action_just_released("click")):
		# Reset click_processed when click is released without placement
		click_processed = false
