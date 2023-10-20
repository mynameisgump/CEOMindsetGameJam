extends RigidBody3D
signal destroyed
@onready var timer: Timer = $Timer;
@onready var hit_sound: AudioStreamPlayer3D = $HitSound;
@onready var grind_sound: AudioStreamPlayer3D = $GrindSound
@onready var collision: CollisionShape3D = $CollisionShape3D
var off_ground;


var delete = false;

func destroy():
	destroyed.emit()
	grind_sound.play()
	delete = true;
	self.visible = false;
	collision.queue_free()
	#queue_free()

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
	if (delete and not grind_sound.is_playing()):
		
		queue_free()

