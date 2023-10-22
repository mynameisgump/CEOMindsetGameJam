extends Control

signal upgrade(upgrade_name);
signal open_hud(value);

@onready var canvas_layer = $CanvasLayer
@onready var ui = $CanvasLayer/UI
@onready var upgrade_ui = $CanvasLayer/UI/Upgrades
@onready var animation_player = $SubViewport/AnimationPlayer
@onready var meat_sphere = $SubViewport/MeatSphere
@onready var vac = $SubViewport/Vacum

var open = false;
var total_money = 0;

func set_money(new_money):
	var money_label: Label = canvas_layer.get_child(0);
	total_money = new_money;
	money_label.text = str("Money: ",new_money);

func set_succ_meat(new_meat, vac_max):
	var meat_label: Label = canvas_layer.get_child(1);
	meat_label.text = str("Vac Meat: ", new_meat,"/",vac_max);

func _ready():
	animation_player.play("rotate_Vac")
	ui.visible = false;

func _process(delta):
	if upgrade_ui.current_tab == 0:
		if not vac.visible:
			vac.visible = true
			meat_sphere.visible = false
			
	if upgrade_ui.current_tab == 1:
		if not meat_sphere.visible:
			meat_sphere.visible = true;
			vac.visible = false
			
	if Input.is_action_just_pressed("open_ui"):
		if ui.visible:
			open_hud.emit(false);
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
			ui.visible = false;
		else:
			open_hud.emit(true);
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			ui.visible = true;
	pass

func _on_max_meat_but_pressed():
	print("Pressed")
	if (total_money-100>=0):
		upgrade.emit("max_meat")
	pass # Replace with function body.


func _on_increase_dissolve_but_pressed():
	if (total_money-100>=0):
		upgrade.emit("meat_dissolve")
	pass # Replace with function body.
