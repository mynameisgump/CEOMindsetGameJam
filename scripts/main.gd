extends Node3D

@onready var meat = $Meat;
@onready var grinding_area = $Map/meat_grinder/GrindingArea;
@onready var vat = $Map/meat_grinder/GrindingArea/Vat;
@onready var meat_sphere_spawn = $truck/SpawnPoint;
@onready var meat_spawn_timer = $MeatSpawnTimer;

var MeatSphere = preload("res://scenes/meat_sphere.tscn");

const totalMeats = 1000;
var money = 0;

var meat_to_spawn = 0;
func add_meat_spheres(num: int):
	for i in range(1,num,1):
		var x = randf_range(-5,5);
		var z = randf_range(-5,5);
		var y = randf_range(20,60);
		var meat_sphere = MeatSphere.instantiate();
		meat.add_child(meat_sphere);
		meat_sphere.connect("destroyed",self._on_meat_destroyed)
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
	print(meat_to_spawn)
	if meat_to_spawn > 0:
		if meat_spawn_timer.is_stopped():
			var x = randf_range(-2,2);
			var meat_sphere = MeatSphere.instantiate();
			meat.add_child(meat_sphere);
			meat_sphere.set_position(meat_sphere_spawn.global_position);
			meat_sphere.apply_central_impulse(Vector3(x,0,10))
			meat_to_spawn -= 1
			meat_spawn_timer.start()

	

	
