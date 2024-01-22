extends Node2D

@onready var sm = get_tree().get_root().get_node("SceneManager")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	print("test")


func _on_tutorial_pressed():
	sm.loadLevel("tutorial")


func _on_lv_1_pressed():
	sm.loadLevel("level1")


func _on_lv_2_pressed():
	sm.loadLevel("level2")


func _on_lv_3_pressed():
	sm.loadLevel("level3")


func _on_lv_4_pressed():
	sm.loadLevel("level4")


func _on_lv_5_pressed():
	sm.loadLevel("level5")
