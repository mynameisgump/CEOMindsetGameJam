extends Node3D

@onready var meat = $Meat;
@onready var grinding_area = $Map/meat_grinder/GrindingArea;
@onready var vat = $Map/meat_grinder/GrindingArea/Vat;
@onready var meat_sphere_spawn = $truck/SpawnPoint;
@onready var meat_spawn_timer = $MeatSpawnTimer;

var MeatSphere = preload("res://scenes/meat_sphere.tscn");

const totalMeats = 1000;
var money = 0;
const max_meat = 4000;

var meat_to_spawn = 0;
		
func add_meat_sphere():
	var x = randf_range(-96,96);
	var z = randf_range(-96,96);
	var y = randf_range(20,60);
	var meat_sphere = MeatSphere.instantiate();
	meat.add_child(meat_sphere);
	# meat_sphere.connect("destroyed",self._on_meat_destroyed)
	meat_sphere.set_position(Vector3(x,y,z));


func _ready():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("add100"):
		meat_to_spawn = 50;

	if Input.is_action_just_pressed("player_dump_vat"):
		grinding_area.resume_grinding();
		vat.dump()
		money += 100
	
	var total_meat = meat.get_child_count();
	print(total_meat)
	#if meat_to_spawn > 0:
	if meat_spawn_timer.is_stopped() && total_meat < max_meat:
		add_meat_sphere();
		meat_spawn_timer.start()
#			var x = randf_range(-2,2);
#			var meat_sphere = MeatSphere.instantiate();
#			meat.add_child(meat_sphere);
#			meat_sphere.set_position(meat_sphere_spawn.global_position);
#			meat_sphere.apply_central_impulse(Vector3(x,0,10))
#			meat_to_spawn -= 1
#			meat_spawn_timer.start()

	

	
