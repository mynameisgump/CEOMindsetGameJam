extends Area3D
@onready var GrindSound = $GrindSound
@onready var complete_sound = $Complete
@onready var Vat = $Vat
@onready var grinder_particles = $GrinderParticles
signal resume;
var stopped = false;

# var increase_amount = 0.4;
var increase_amount = 0.8;

func resume_grinding():
	var bodies = self.get_overlapping_bodies();
	for body in bodies:
		if (body.is_in_group("Meat")):
			body.destroy()
			Vat.increase_liquid(increase_amount)
			if (!GrindSound.playing):
				GrindSound.play()
		if (body.is_in_group("Player")):
			body.kill()
	stopped = false;
	resume.emit()

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_body_entered(body):
	if (!stopped):
		if (body.is_in_group("Meat")):
			grinder_particles.emitting = true;
			body.destroy()
			Vat.increase_liquid(increase_amount)
			if (!GrindSound.playing):
				GrindSound.play()
		if (body.is_in_group("Player")):
			body.kill();

func _on_vat_full():
	stopped=true;
	complete_sound.play();


func _on_character_body_3d_death():
	pass # Replace with function body.
