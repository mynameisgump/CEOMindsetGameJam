extends Control

@onready var canvas_layer = $CanvasLayer
@onready var ui = $CanvasLayer/UI

func set_money(new_money):
	var money_label: Label = canvas_layer.get_child(0);
	money_label.text = str("Money: ",new_money);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("open_ui"):
		ui.visible = true;
		pass
	if Input.is_action_just_released("open_ui"):
		ui.visible = false;
	pass
