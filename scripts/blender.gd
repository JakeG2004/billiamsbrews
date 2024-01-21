extends Node2D

enum {HEALING, FIRE, STRENGTH, SHINE, JUMP, POISON, FAIL, NOPOT}

var ingredients = []
var size
var currentPot = NOPOT

@onready var ap = get_node("Blender/AnimationPlayer")

var click_processed = false  # Flag to track whether the click has been processed

func _process(_delta):
	# set size of bottle
	if (get_node_or_null("bottle")):
		size = get_node_or_null("bottle").size
		return
	size = "empty"

func append(ingredient):
	# duplicate filter
	if (ingredients.has(ingredient)):
		return

	# add ingredient
	ingredients.append(ingredient)

func addPotion(bottleSize):
	size = bottleSize
	print(size)

func blend():
	ap.play("blend")
	var returnValue = FAIL

	# handle incorrect input
	if (ingredients.size() < 3):
		return NOPOT

	# Healing potion
	if (ingredients.has("leaf") and ingredients.has("pedal") and ingredients.has("honey") and ingredients.size() == 3):
		returnValue = HEALING
	# Fire resist potion
	if (ingredients.has("obsidian") and ingredients.has("gold") and ingredients.has("honey") and ingredients.size() == 3):
		returnValue = FIRE
	# Strength potion
	if (ingredients.has("blood") and ingredients.has("obsidian") and ingredients.has("burger") and ingredients.size() == 3):
		returnValue = STRENGTH
	# Shine potion
	if (ingredients.has("firefly") and ingredients.has("honey") and ingredients.has("pedal") and ingredients.size() == 3):
		returnValue = SHINE
	# Jump potion
	if (ingredients.has("spring") and ingredients.has("firefly") and ingredients.has("leaf") and ingredients.size() == 3):
		returnValue = JUMP
	# Poison potion
	if (ingredients.has("blood") and ingredients.has("obsidian") and ingredients.has("firefly") and ingredients.size() == 3):
		returnValue = POISON

	empty()
	return returnValue

func empty():
	print("empty")
	ingredients = []

func pour():
	if (size != "empty" and currentPot != NOPOT):
		# define potion to brew
		var draggable = load("res://scenes/draggables/potions/potion.tscn")

		# instantiate potion
		var potion = draggable.instantiate()
		add_child(potion)
		potion.setData(size, currentPot)

		# delete old bottle
		get_node("bottle").queue_free()
		size = "empty"

func _on_blend(_viewport, _event, _shape_idx):
	if (Input.is_action_just_pressed("click") and not click_processed):
		currentPot = blend()
		print(currentPot)
		click_processed = true

func _on_empty(_viewport, _event, _shape_idx):
	if (Input.is_action_just_pressed("click") and not click_processed):
		empty()
		click_processed = true

func _on_pour(_viewport, _event, _shape_idx):
	if (Input.is_action_just_pressed("click") and not click_processed):
		pour()
		click_processed = true

func _input(event):
	if (Input.is_action_just_released("click")):
		click_processed = false  # Reset the flag
