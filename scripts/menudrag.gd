extends Node2D

var selected = false
var rest_point
var rest_nodes = []
@export var size = "none"
@export var type = 0

var play_card
var music_card
var credits_card
var exit_card

var gone = false

var click_processed = false

@onready var sm = get_tree().get_root().get_node("SceneManager")

func _ready():
	rest_nodes = get_tree().get_nodes_in_group("potzone")
	rest_point = global_position

	# Assuming you have nodes named "SuccessCard" and "FailureCard"
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
				rest_point = child.global_position
				#shortest_dist = distance
				closest_card = child

		if (closest_card && !click_processed):
			handle_potion_placement(closest_card)

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)

func handle_potion_placement(card):
	
	#This is foul but it works
	if(click_processed):
		return
	click_processed = true
	print("test")
	
	await get_tree().create_timer(.25).timeout
	if card == play_card:
		sm.loadLevel("levels")
		
	if card == music_card:
		sm.loadLevel("music")
		
	if card == credits_card:
		sm.loadLevel("credits")
		
	if card == exit_card:
		get_tree().quit()
	
func _input(_event):
	if(Input.is_action_just_released("click")):
		click_processed = false
