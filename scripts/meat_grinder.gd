extends Node3D

@onready var animation_player = $AnimationPlayer
@onready var GrindingArea = $GrindingArea
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("Spinnin")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass