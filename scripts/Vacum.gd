extends Area3D

@onready var suction_point = $SuctionPoint;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = self.get_overlapping_bodies();
	
	for body in bodies:
		if body.is_in_group("Meat"):
			var direction = suction_point.global_position - body.global_position;
			body.apply_central_impulse(direction/10);
	pass


#func _on_body_entered(body: RigidBody3D):
#	print(body);
#	
#	if(body.is_in_group("Meat")):
#		
#	pass # Replace with function body.
