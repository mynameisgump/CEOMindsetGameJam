extends Node3D

@onready var meat = $Meat;
@onready var grinding_area = $Map/meat_grinder/GrindingArea;
@onready var vat = $Map/meat_grinder/GrindingArea/Vat;
@onready var meat_sphere_spawn = $truck/SpawnPoint;
@onready var meat_spawn_timer = $MeatSpawnTimer;
@onready var hud = $HUD;
@onready var player = $CharacterBody3D;
@onready var generic_ambient = $GenericAmbient;


var MeatSphere = preload("res://scenes/meat_sphere.tscn");

const totalMeats = 0;
var money = 0;
const max_meat = 1000;

#var meat_to_spawn = 0;
var spawning = true;
var spawn_impulse_strength = 2;
var current_dissolve_time = 5;

var vat_full = false;

func add_meat_sphere():
	var x = randf_range(-96,96);
	var z = randf_range(-96,96);
	var y = randf_range(20,60);
	var impulse_x = randf_range(-1,1)*spawn_impulse_strength;
	var impulse_z = randf_range(-1,1)*spawn_impulse_strength;

	var meat_sphere = MeatSphere.instantiate();
	meat_sphere.dissolve_time = current_dissolve_time;
	meat.add_child(meat_sphere);
	meat_sphere.set_position(Vector3(x,y,z));
	meat_sphere.apply_impulse(Vector3(impulse_x,0,impulse_z))

func handle_ui(delta):
	if not player.dead:
		hud.set_succ_meat(player.total_meat_spheres, player.vac_max);
		hud.set_money(money);

func _ready():
	generic_ambient.play()
	pass
	
func _process(delta):
	handle_ui(delta);

	if Input.is_action_just_pressed("player_dump_vat"):
		if vat_full:
			vat_full = false;
			grinding_area.resume_grinding();
			vat.dump()
			money += 100
	
	var total_meat = meat.get_child_count();
	# Raining Meat Spheres
	total_meat = meat.get_child_count();
	if spawning:
		if meat_spawn_timer.is_stopped() && total_meat < max_meat:
			add_meat_sphere();
			var new_time = randf_range(0.05,0.06);

			meat_spawn_timer.wait_time = new_time;
			meat_spawn_timer.start();

func _on_character_body_3d_shoot_meat_sphere(new_position, impulse):
	var meat_sphere = MeatSphere.instantiate();
	meat.add_child(meat_sphere);
	var impulse_strength = 10;
	meat_sphere.set_position(new_position);
	meat_sphere.apply_impulse(impulse*impulse_strength);

func _on_hud_upgrade(upgrade_name):
	money -= 100;
	if upgrade_name == "meat_dissolve":
		current_dissolve_time += 1;

func _on_vat_full():
	vat_full = true
