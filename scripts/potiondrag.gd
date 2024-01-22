extends Node2D

var selected = false
var rest_point
var rest_nodes = []
@export var size = "none"
@export var type = 0

var success_card
var failure_card

var click_processed = false

@onready var ap = get_node("AnimationPlayer")

@onready var cc = get_tree().get_root().get_node("SceneManager/World/CustomerController")

func _ready():
	var pot_point = get_tree().get_root().get_node("SceneManager/World/blender/potion")
	rest_nodes = get_tree().get_nodes_in_group("potzone")
	rest_point = pot_point.global_position
	global_position = rest_point

	# Assuming you have nodes named "SuccessCard" and "FailureCard"
	success_card = get_tree().get_root().get_node("SceneManager/World/pass")
	failure_card = get_tree().get_root().get_node("SceneManager/World/fail")

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

func setData(dSize, dType):
	size = dSize
	type = dType
	var tmp = size + str(type)
	get_node("Icon").texture = load("res://assets/potions/" + tmp + ".png")

func handle_potion_placement(card):
	if card == success_card:
		# Handle success card logic here
		passToCustomer()
		return
	# Handle failure card logic here
	destroyPot()
		
func passToCustomer():
	cc.getPotion(size, type)
	cc.newCustomer()
	ap.play("pass")
	await get_tree().create_timer(2).timeout
	queue_free()
	
func destroyPot():
	ap.play("destroy")
	await get_tree().create_timer(2).timeout
	queue_free()
	
func _input(_event):
	if(Input.is_action_just_released("click")):
		click_processed = false
