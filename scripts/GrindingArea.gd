extends Area3D
@onready var GrindSound = $GrindSound
@onready var Vat = $Vat

var stopped = false;



func resume_grinding():
	print("Resuming")
	var bodies = self.get_overlapping_bodies();
	for body in bodies:
		if (body.is_in_group("Meat")):
			body.destroy()
			Vat.increase_liquid(0.05)
			if (!GrindSound.playing):
				GrindSound.play()
	stopped = false;

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_body_entered(body):
	if (!stopped):
		if (body.is_in_group("Meat")):
			body.destroy()
			Vat.increase_liquid(0.05)
			if (!GrindSound.playing):
				GrindSound.play()

func _on_vat_full():
	stopped=true;

