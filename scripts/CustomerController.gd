extends Node2D

enum {LIGHTMAGE, DARKMAGE}

@export var lightMages = 9
@export var darkMages = 3
@export var minPoints = 9
@export var level = 1

@onready var bubble = get_tree().get_root().get_node("SceneManager/World/OrderBubble")
@onready var audio = get_node("AudioStreamPlayer")
@onready var label = get_node("remaining")
@onready var timer = get_parent().get_node("musicplayer")
@onready var ap = get_node("AnimationPlayer")
@onready var sm = get_tree().get_root().get_node("SceneManager")

var sizeRequest
var typeRequest
var customerType

var numCorrect = 0
var numIncorrect = 0
var poisons = 0

var mageList = []

var potions = ["healing", "fire resistance", "strength", "shine", "jump boost", "poison", "fail"]

var rng = RandomNumberGenerator.new()

var score = 0

var scoreShown = false

func _process(_delta):
	label.text = "Customers Remaining: " + str(mageList.size())
	if(!timer.is_playing()):
		showScore()
		
func _ready():
	
	%minpoints.text = "Required Score: " + str(minPoints)
	#Construct list of mages per level
	for i in range(lightMages + darkMages):
		if(i < lightMages):
			mageList.append(LIGHTMAGE)
		else:
			mageList.append(DARKMAGE)
			
	await get_tree().create_timer(2).timeout
	newCustomer()

func newCustomer():
	
	if(mageList.size() == 0):
		showScore()
		return 1

	customerType = mageList.pop_at(rng.randi_range(0, mageList.size() - 1))
	typeRequest = potions[rng.randi_range(0, 4)]
	
	var sizes = ["small", "medium", "large"]
	sizeRequest = sizes[rng.randi_range(0, 2)]
	
	bubble.showBubble(sizeRequest, typeRequest, customerType)
	
	return 0
	
func getPotion(size, type):
	type = potions[type]
	var tmp = load("res://assets/audio/luscious_metal_scraps.mp3")
	#Handle darkmage
	if(customerType == DARKMAGE):
		if(type != "poison"):
			score -= 3
			tmp = load("res://assets/audio/old_mush.mp3")
			numIncorrect += 1
		else:
			score += 1
			poisons += 1
		
	#handle regular customer
	if(customerType == LIGHTMAGE):
		if(size != sizeRequest or type != typeRequest):
			score -= 1
			tmp = load("res://assets/audio/old_mush.mp3")
			numIncorrect += 1
		else:
			score += 1
			numCorrect += 1
	
	audio.stream = tmp
	audio.play()

	%score.text = "Score: " + str(score)
	%incorrect.text = "Incorrect: " + str(numIncorrect)
	%correct.text = "Correct: " + str(numCorrect)
	%poisons.text = "Poisons: " + str(poisons)
	
func showScore():
	if(scoreShown):
		return
	if(score < minPoints):
		%next.hide()
	scoreShown = true
	ap.play("showScore")


func _on_menu_pressed():
	sm.loadLevel("menu")

func _on_restart_pressed():
	sm.reload()

func _on_next_pressed():
	sm.loadLevel("level" + str(level + 1))
