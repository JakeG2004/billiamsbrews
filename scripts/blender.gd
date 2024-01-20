extends Node2D

enum {HEALING, FIRE, STRENGTH, SHINE, JUMP, POISON, FAIL, NOPOT}

var ingredients = []
var size
var currentPot = NOPOT

func _process(_delta):
	#set size of bottle
	if(get_node_or_null("bottle")):
		size = get_node_or_null("bottle").size
		return
	size = "empty"

func append(ingredient):
	#duplicate filter
	if(ingredients.has(ingredient)):
		return
	
	#add ingredient
	ingredients.append(ingredient)
	
func addPotion(bottleSize):
	size = bottleSize
	print(size)
	
func blend():
	var  returnValue = FAIL
	
	#handle incorrect input
	if(ingredients.size() < 3):
		return NOPOT

	#Healing potion
	if(ingredients.has("leaf") and ingredients.has("pedal") and ingredients.has("honey") and ingredients.size() == 3):
		returnValue =  HEALING
	#Fire resist potion
	if(ingredients.has("obsidian") and ingredients.has("gold") and ingredients.has("honey") and ingredients.size() == 3):
		returnValue = FIRE
	#Strength potion
	if(ingredients.has("blood") and ingredients.has("obsidian") and ingredients.has("burger") and ingredients.size() == 3):
		returnValue = STRENGTH
	#Shine potion
	if(ingredients.has("firefly") and ingredients.has("honey") and ingredients.has("pedal") and ingredients.size() == 3):
		returnValue = SHINE
	#Jump potion
	if(ingredients.has("spring") and ingredients.has("firefly") and ingredients.has("leaf") and ingredients.size() == 3):
		returnValue = JUMP
	#Poison potion
	if(ingredients.has("blood") and ingredients.has("obsidian") and ingredients.has("firefly") and ingredients.size() == 3):
		returnValue = POISON
		
	empty()
	return returnValue
		
func empty():
	print("empty")
	ingredients = []
	
func pour():
	if(size != "empty" and currentPot != NOPOT):
		#define potion to brew
		var pot = "res://scenes/draggables/potions/" + size + str(currentPot) + ".tscn"
		var draggable = load(pot)
		
		#instantiate potion
		var potion = draggable.instantiate()
		add_child(potion)
		potion.setData(size, currentPot)
		
		#delete old bottle
		get_node("bottle").queue_free()
		size = "empty"
	
func _on_blend(_viewport, _event, _shape_idx):
	if(Input.is_action_just_pressed("click")):
		currentPot = blend()
		print(currentPot)
		
func _on_empty(_viewport, _event, _shape_idx):
	if(Input.is_action_just_pressed("click")):
		empty()
		
func _on_pour(_viewpoer, _event, _shape_idx):
	if(Input.is_action_just_pressed("click")):
		pour()

