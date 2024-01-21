extends Node2D

@onready var ap = get_node("AnimationPlayer")
@onready var label = get_node("Bubble/Label")

enum {LIGHTMAGE, DARKMAGE}

func _process(_delta):
	pass
	
func showBubble(size, type, mage):
	
	#set font color to indicate mage type
	label.set("theme_override_colors/font_color", Color("8d209e"))
	if(mage == LIGHTMAGE):
		label.set("theme_override_colors/font_color", Color("000000"))
		
	label.text = "Hello, I would like a\n" + size + " " + type + " potion"
	
	ap.play("showBubble")
