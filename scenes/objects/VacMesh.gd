extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var currently_sucking = false;

func _ready():
	pass 

func _process(delta):
	pass

func _on_character_body_3d_sucking(value):
	if value and currently_sucking == false:
		animation_player.play("Start_succ");
		animation_player.queue("succing");
	if not value:
		animation_player.play("Stop_Succ");
	pass # Replace with function body.


func _on_character_body_3d_spewing_sig(is_spewing):
	if is_spewing and currently_sucking == false:
		animation_player.play("Spew")
	if not is_spewing:
		animation_player.play("StopSpew")
	pass # Replace with function body.
