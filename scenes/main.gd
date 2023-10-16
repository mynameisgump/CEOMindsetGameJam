extends Node3D

@onready var meat = $Meat;

var MeatSphere = preload("res://scenes/meat_sphere.tscn");

const totalMeats = 1000;
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(1,totalMeats,1):
		var x = randf_range(-5,5);
		var z = randf_range(-5,5);
		var y = randf_range(20,60);
		# print("????")
		var meat_sphere = MeatSphere.instantiate();
		# print(meat.get_child_count())
		meat.add_child(meat_sphere);
		meat_sphere.set_position(Vector3(x,y,z));
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("add100"):
		for i in range(1,100,1):
			var x = randf_range(-5,5);
			var z = randf_range(-5,5);
			var y = randf_range(20,60);
			# print("????")
			var meat_sphere = MeatSphere.instantiate();
			# print(meat.get_child_count())
			meat.add_child(meat_sphere);
			meat_sphere.set_position(Vector3(x,y,z));


