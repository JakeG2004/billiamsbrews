extends Node2D

@onready var ap = get_node("AnimationPlayer")
@onready var label = get_node("Bubble/Label")
@onready var sm = get_tree().get_root().get_node("SceneManager")

var click_processed = false

var currentDialogue = 0

var dialogue = ["Hello, I'm Billiam and this\nis my brewery.\n[left click to continue]", "You're new on the job right?\nLet me show ya round!", "We've got the ingredients up\ntop and bottles to the left",
"Feel free to play with them\nfor a bit if you would like", "And here in the middle,\nwell this is the heart of\nthe business.", "This is my magic blender!\nIgnore the duct tape", "I accidentally put\na demon inside :3",
"As you're well aware of,\nwe are in the middle of a war", "A war between the dark\nmages and the light mages.", "Being on the side of the light\nmages, we don't want to\nhelp the dark mages.", 
"But before that, let\nme show you how to\nbrew a potion!", "First, drag a sunflower\npedal into the blender.\n", "Then, drag a honey\ncomb into the blender.", "Last, drag a leaf\ninto the blender.", 
"Now, grab a bottle from\nthe left. It doesn't\nmatter which one.", "Put it on the\npedestal next to the\n blender.", "Now, use the right button\nto cast 'Blend' on the\nblender.", "Press the middle
button to pour out the\npotion.", "Voila! Now, if this is what\nthe customer asked for, put\nit on the green card.", "Otherwise, put it on the\nred card to destroy it.", "The left button will\npour out your
current mix.", "If you need any help with\nany potion recipes, then\nconsult your book.", "It's along the bottom\nof the store.", "Remember, if any dark mages\ncome by, they will talk a\nlittle different",
"Like this.", "Serve them somethin' bad\nif they show up.", "Now, we have a good store\nof potions, so you shouldn't\nhave to make too many.", "PUT YOUR\nWANDS IN\nTHE AIR!", "THIS IS\nA HOLDUP!", "I'M NOT\nAFRAID TO USE\nFIREBALL!", "GIVE ME YOUR
BEST\nPOTIONS!", "NOW!", "Alright, Okay!\nHere, take them!", "Now get out!", "Well kid, it looks like\nthe stock we had\nis gone now.", "Good luck!", "See ya later kid!"]

enum {LIGHTMAGE, DARKMAGE}

func _ready():
	showBubble()

func _process(_delta):
	if(Input.is_action_just_pressed("click") && !click_processed):
		click_processed = true
		currentDialogue += 1
		showBubble()
		
	if(Input.is_action_just_released("click")):
		click_processed = false
		
	if(currentDialogue >= dialogue.size() - 1):
		sm.loadLevel("level1")
	
func showBubble():
		
	label.set("theme_override_colors/font_color", Color("000000"))
	if(currentDialogue == 24 || currentDialogue >= 27):
		label.set("theme_override_colors/font_color", Color("8d209e"))
		
	if(currentDialogue >= 32):
		label.set("theme_override_colors/font_color", Color("000000"))
	
	label.text = str(dialogue[currentDialogue])
	
	ap.play("tutorial")
