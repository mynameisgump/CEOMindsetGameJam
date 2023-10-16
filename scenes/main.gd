extends Node3D

@onready var meat = $Meat;
@onready var animation_player = $AnimationPlayer;

var MeatSphere = preload("res://scenes/meat_sphere.tscn");

const totalMeats = 1000;
var money = 0;
# Called when the node enters the scene tree for the first time.
func add_meat_spheres(num: int):
	for i in range(1,num,1):
		var x = randf_range(-5,5);
		var z = randf_range(-5,5);
		var y = randf_range(20,60);
		# print("????")
		var meat_sphere = MeatSphere.instantiate();
		# print(meat.get_child_count())
		meat.add_child(meat_sphere);
		meat_sphere.connect("destroyed",self._on_meat_destroyed)
		meat_sphere.set_position(Vector3(x,y,z));


func _ready():
	add_meat_spheres(totalMeats);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("add100"):
		for i in range(1,100,1):
			var x = randf_range(-5,5);
			var z = randf_range(-5,5);
			var y = randf_range(20,60);
			var meat_sphere = MeatSphere.instantiate();
			meat.add_child(meat_sphere);
			meat_sphere.connect("destroyed",self._on_meat_destroyed)
			meat_sphere.set_position(Vector3(x,y,z));
	if Input.is_action_just_pressed("add500"):
		animation_player.play("MoveCameraMiddle")
	print(money)


func _on_meat_destroyed():
	money += 10
	
