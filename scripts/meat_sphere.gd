extends RigidBody3D
signal destroyed
@onready var timer: Timer = $Timer;
@onready var hit_sound: AudioStreamPlayer3D = $HitSound;

var off_ground;

func destroy():
	destroyed.emit()
	queue_free()

func dissolve():
	queue_free()
	
func play_hit_sound():
	hit_sound.play();
	
func _ready():
	timer.start()

func _process(delta):
	pass

func _on_body_entered(body):
	if(body.is_in_group("concrete")):
		#play_hit_sound();
		hit_sound.play();

