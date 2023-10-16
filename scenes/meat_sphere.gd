extends RigidBody3D
signal destroyed
@onready var timer: Timer = $Timer;

func destroy():
	destroyed.emit()
	queue_free()

func dissolve():
	queue_free()
	
func _ready():
	timer.start()

func _process(delta):
	#if timer.is_stopped():
	#	dissolve()
	pass
