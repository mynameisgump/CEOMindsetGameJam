extends Node3D

@onready var animation_player = $AnimationPlayer
@onready var GrindingArea = $GrindingArea
@onready var GrinderWhirr = $GrinderWhirr;
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("Spinnin")
	GrinderWhirr.play();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_vat_full():
	animation_player.stop()
	GrinderWhirr.stop()
	pass # Replace with function body.


func _on_grinding_area_resume():
	animation_player.play("Spinnin")
	GrinderWhirr.play();
	pass # Replace with function body.
