extends Node2D

enum {HEALING, FIRE, STRENGTH, SHINE, JUMP, FAIL}

var ingredients = []
	
func select():
	for child in get_tree().get_nodes_in_group("zone"):
		child.deselect()
	modulate = Color.WEB_MAROON
	
func deselect():
	modulate = Color.WHITE

func append(ingredient):
	if(ingredients.has(ingredient)):
		return
	ingredients.append(ingredient)
	print(ingredients)
	
func blend():
	#Healing potion
	if(ingredients.has("leaf") and ingredients.has("pedal") and ingredients.has("honey") and ingredients.size() == 3):
		return HEALING
	#Fire resist potion
	if(ingredients.has("obsidian") and ingredients.has("gold") and ingredients.has("honey") and ingredients.size() == 3):
		return FIRE
	#Strength potion
	if(ingredients.has("blood") and ingredients.has("obsidian") and ingredients.has("burger") and ingredients.size() == 3):
		return STRENGTH
	#Shine potion
	if(ingredients.has("firefly") and ingredients.has("honey") and ingredients.has("pedal") and ingredients.size() == 3):
		return SHINE
	#Jump potion
	if(ingredients.has("spring") and ingredients.has("firefly") and ingredients.has("leaf") and ingredients.size() == 3):
		return JUMP
		
	return FAIL
		
func empty():
	ingredients = []
	
func pour(size, type):
	pass

