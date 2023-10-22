extends RigidBody3D
signal destroyed
@onready var timer: Timer = $Timer;
@onready var hit_sound: AudioStreamPlayer3D = $HitSound;
@onready var grind_sound: AudioStreamPlayer3D = $GrindSound
@onready var collision: CollisionShape3D = $CollisionShape3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var off_ground;


var delete = false;
func remove():
	# Play Shlurp?
	queue_free();

func destroy():
	destroyed.emit()
	grind_sound.play()
	delete = true;
	self.visible = false;
	collision.queue_free()

func dissolve():
	animation_player.play("Dissolve");
	delete = true;

	
func play_hit_sound():
	hit_sound.play();
	
func _ready():
	pass

func _process(delta):
	if timer.is_stopped() and !delete:
		dissolve()
	if (delete and not grind_sound.is_playing() and !animation_player.is_playing()):
		queue_free()
	pass

func _on_body_entered(body):
	if(body.is_in_group("concrete")):
		hit_sound.play();
	
	
	

