extends Node2D

var isUp = false
@onready var ap = get_node("AnimationPlayer")
@onready var sm = get_tree().get_root().get_node("SceneManager")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(Input.is_action_just_pressed("menu")):
		if(!isUp):
			isUp = true
			ap.play("menu")
			
		else:
			isUp = false
			ap.play_backwards("menu")


func _on_resume_pressed():
	isUp = false
	ap.play_backwards("menu")


func _on_restart_pressed():
	sm.reload()


func _on_menu_pressed():
	sm.loadLevel("menu")
