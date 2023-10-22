extends Node3D

const MOUSE_SENS : float = 3.0

@onready var character : CharacterBody3D = get_parent()

var dead = false;
var menu_opened = false;
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event : InputEvent) -> void:
	
	if event is InputEventMouseMotion and not dead and not menu_opened:
		rotation.x -= event.relative.y * MOUSE_SENS * 0.001
		rotation.x = clamp(rotation.x, -1.5, 1.5)

		character.rotation.y -= event.relative.x * MOUSE_SENS * 0.001
		character.rotation.y = wrapf(character.rotation.y, 0.0, TAU)



func _on_character_body_3d_death():
	dead = true
	pass # Replace with function body.


func _on_character_body_3d_menu_opened(value):
	menu_opened = value
	pass # Replace with function body.
