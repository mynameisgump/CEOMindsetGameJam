extends Area3D
@onready var GrindSound = $GrindSound
@onready var complete_sound = $Complete
@onready var Vat = $Vat
signal resume;
var stopped = false;

var increase_amount = 0.4;

func resume_grinding():
	print("Resuming")
	var bodies = self.get_overlapping_bodies();
	for body in bodies:
		if (body.is_in_group("Meat")):
			body.destroy()
			Vat.increase_liquid(0.4)
			if (!GrindSound.playing):
				GrindSound.play()
	stopped = false;
	resume.emit()

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_body_entered(body):
	if (!stopped):
		if (body.is_in_group("Meat")):
			body.destroy()
			Vat.increase_liquid(0.4)
			if (!GrindSound.playing):
				GrindSound.play()

func _on_vat_full():
	stopped=true;
	complete_sound.play();
