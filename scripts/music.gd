extends Node2D

var tracks = ["potion_o_invisibility", "potion_o_healing", "failure_jingle", "another_fire_protection_potion", "potion_o_fire_armor", "mysterious_tree_bark", "maybe_grass", "second_theme", "cats_theme", "first_theme_sploingy", "luscious_metal_scraps", "old_mush", "close-text", "open-text"]
var currentTrack = 0

@onready var player = get_node("AudioStreamPlayer")

@onready var current = get_node("VBoxContainer/current")

func _process(_delta):
	current.text = tracks[currentTrack]

func _on_back_pressed():
	currentTrack -= 1
	if(currentTrack < 0):
		currentTrack = tracks.size() - 1

func _on_next_pressed():
	currentTrack = (currentTrack + 1) % tracks.size()

func _on_play_pressed():
	var tmp = "res://assets/valin/" + tracks[currentTrack] + ".mp3"
	player.stream = load(tmp)
	if(!player.is_playing()):
		player.play()
		return
	player.pause()
