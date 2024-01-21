extends Node2D

var currentPage = 1

var stored = true

@onready var ap = get_node("AnimationPlayer")
@onready var page = %page
@onready var audio = %AudioStreamPlayer
@onready var toggleButton = get_node("pageContainer/toggle")


func _on_forward(_viewport, _event, _shape_idx):
	if(Input.is_action_just_pressed("click") && currentPage < 8):
		currentPage += 1
		var tmp = "res://assets/gui/spellbook/spellbook-" + str(currentPage) + ".png"
		page.texture = load(tmp)
		audio.stream = load("res://assets/audio/page-flip-47177.mp3")
		audio.play()

func _on_back(_viewport, _event, _shape_idx):
	if(Input.is_action_just_pressed("click") && currentPage > 1):
		currentPage -= 1
		var tmp = "res://assets/gui/spellbook/spellbook-" + str(currentPage) + ".png"
		page.texture = load(tmp)
		audio.stream = load("res://assets/audio/page-flip-47177.mp3")
		audio.play()


func _on_toggle(_viewport, _event, _shape_idx):
	if(!Input.is_action_just_pressed("click")):
		return
	toggleButton.scale.y *= -1
	if(stored):
		ap.play("toggle")
		stored = false
		return
	ap.play_backwards("toggle")
	stored = true
