extends Control

signal upgrade(upgrade_name);

@onready var canvas_layer = $CanvasLayer
@onready var ui = $CanvasLayer/UI

var open = false;
var total_money = 0;

func buy_upgrade():
	
	pass

func set_money(new_money):
	var money_label: Label = canvas_layer.get_child(0);
	total_money = new_money;
	money_label.text = str("Money: ",new_money);

func set_succ_meat(new_meat, vac_max):
	var meat_label: Label = canvas_layer.get_child(1);
	meat_label.text = str("Vac Meat: ", new_meat,"/",vac_max);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("open_ui"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		ui.visible = true;
		pass
	if Input.is_action_just_released("open_ui"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
		ui.visible = false;
	pass



func _on_max_meat_but_pressed():
	print("Pressed")
	if (total_money-100>=0):
		upgrade.emit("max_meat")
	pass # Replace with function body.
