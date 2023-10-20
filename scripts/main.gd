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
var spawning = false;
		
func add_meat_sphere():
	#var x = randf_range(-96,96);
	#var z = randf_range(-96,96);
	var x = randf_range(-10,10);
	var z = randf_range(-10,10);
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
		spawning = true;

	if Input.is_action_just_pressed("player_dump_vat"):
		grinding_area.resume_grinding();
		vat.dump()
		money += 100
	
	var total_meat = meat.get_child_count();
	if spawning:
		if meat_spawn_timer.is_stopped() && total_meat < max_meat:
			add_meat_sphere();
			#var new_wait_time = randf_range(0.05,2);
			#meat_spawn_timer.wait_time = new_wait_time
			meat_spawn_timer.start()
