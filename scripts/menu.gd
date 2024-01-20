extends Control

@onready var sm = get_tree().get_root().get_node("SceneManager")

func _on_exit_pressed():
	sm.loadLevel("quit")

func _on_music_pressed():
	sm.loadLevel("music")

func _on_credits_pressed():
	sm.loadLevel("credits")

func _on_start_pressed():
	sm.loadLevel("level1")
