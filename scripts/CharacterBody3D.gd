extends CharacterBody3D

var direction : Vector3;
var target_speed : Vector3;
var accel : float;
var hvel : Vector3;

@onready var head  : Node3D = $Body/Head;
@onready var camera : Camera3D = $Body/Head/Camera3D;
@onready var vacum_tip: Area3D = $Body/VacumTip;
@onready var suction_point: Node3D = $Body/Vacum/SpewPoint;

@onready var sound_vacum_succ: AudioStreamPlayer3D = $VacumSucc;

@onready var succ_particles: GPUParticles3D = $Body/SuccParticles;
@onready var sound_absorbed: AudioStreamPlayer3D = $Absorbed;
@onready var sound_death: AudioStreamPlayer3D = $Death;

@onready var vacum_sounds: Node3D = $Body/VacumSounds;

@onready var body: Node3D = $Body;
@onready var spew_timer: Timer = $SpewTimer;
@onready var barf: AudioStreamPlayer3D = $Barf;

# Preloading Scenes
var absorbed_sound = preload("res://scenes/absorbed_sound.tscn");
var spew_sound = preload("res://scenes/spew_sound.tscn");
var MeatSphere = preload("res://scenes/meat_sphere.tscn");

# Export Vars
@export var GRAVITY = 9.8;
@export var MAX_SPEED: float = 10.0;
@export var JUMP_SPEED = 500;
@export var ACCEL = 4.5;
@export var MAX_ACCEL = 150.0;
@export var DEACCEL= 0.86;
@export var MAX_SLOPE_ANGLE = 40;
@export var default_fov = 75;
@export var vac_max: int = 5;

# Signals
signal sucking(value);
signal shoot_meat_sphere(new_position, impulse);
signal spewing_sig(is_spewing);


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Speed Parameter
const SPEED = 7.0;
# Jump Velocity Parameter
#const JUMP_VELOCITY = 10;
const JUMP_VELOCITY = 10;
# Amount of directional control
const CONTROL : float = 15.0;

# Leaning Variables
var lean_left;
var lean_right;
var z_tilt = 0.0;
var z_tilt_target = 0.0;
var z_tilt_value = 0.01;
var LEAN_SPEED = 5;

var total_meat_spheres = 0;

var absorbed_sounds = [];
var spew_sounds = [];
var spewing = false;
var is_sucking = false;

signal death;
var dead = false;

func kill():
	dead = true;
	sound_death.play();
	death.emit();

func spawn_sound_absorbed():
	var new_sound = absorbed_sound.instantiate();
	vacum_sounds.add_child(new_sound);
	new_sound.play();
	absorbed_sounds.append(new_sound);
	
func spawn_sound_spew():
	var new_sound = spew_sound.instantiate();
	vacum_sounds.add_child(new_sound);
	new_sound.play();
	spew_sounds.append(new_sound);

func is_moving():
	return Input.is_action_pressed("move_left") or \
	Input.is_action_pressed("move_right") or \
	Input.is_action_pressed("move_up") or \
	Input.is_action_pressed("move_down") 

func handle_input(delta : float) -> void:

	z_tilt_target = 0.0
	var cam_xform = camera.get_global_transform()

	if Input.is_action_pressed("move_left"):
		lean_left = true;
		z_tilt_target = z_tilt_value*5;
		
	if Input.is_action_pressed("move_right"):
		lean_right = true;
		z_tilt_target = -z_tilt_value*5;
	
	if Input.is_action_just_pressed("suck") and total_meat_spheres < vac_max:
		sound_vacum_succ.play();
		succ_particles.emitting = true;
		sucking.emit(true);
		is_sucking = true;

	if (Input.is_action_just_released("suck") or total_meat_spheres >= vac_max) and is_sucking:
		print("Stoping Suc")
		sound_vacum_succ.stop();
		succ_particles.emitting = false;
		sucking.emit(false);
		is_sucking = false;

	if Input.is_action_just_pressed("spew"):
		spewing_sig.emit(true);
		barf.play();
		spewing = true;

	if Input.is_action_just_released("spew"):
		spewing_sig.emit(false);
		barf.stop();
		spewing = false;

func handle_movement(delta : float) -> void:
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta * CONTROL)

	hvel = velocity
	hvel.y = 0.0
	hvel *= DEACCEL

	if hvel.length() < MAX_SPEED * 0.01:
		hvel = Vector3.ZERO

	var speed = hvel.dot(direction)

	var accel = clamp(MAX_SPEED - speed, 0.0, MAX_ACCEL * delta)
	hvel += direction * accel
	
	velocity.x = hvel.x
	velocity.z = hvel.z

	# Leaning code
	z_tilt += (z_tilt_target-z_tilt)*LEAN_SPEED*delta
	head.rotation.z = z_tilt

	move_and_slide()


func _physics_process(delta):
	if not dead:
		handle_movement(delta)
		handle_input(delta)

		if spewing && total_meat_spheres > 0 && spew_timer.is_stopped():
			spew_timer.start();
			total_meat_spheres -= 1;
			var forward: Vector3 = -self.get_global_transform().basis.z;
			shoot_meat_sphere.emit(suction_point.global_position,forward);
			spawn_sound_spew();

		if (absorbed_sounds.size() > 0):
			for sound in absorbed_sounds:
				if sound.is_playing() == false:
					absorbed_sounds.erase(sound);
					sound.queue_free()
					
		if (spew_sounds.size() > 0):
			for sound in spew_sounds:
				if sound.is_playing() == false:
					spew_sounds.erase(sound);
					sound.queue_free()

func _on_vacum_tip_body_entered(body):
	if body.is_in_group("Meat") and is_sucking and total_meat_spheres < vac_max:
		body.remove();
		total_meat_spheres += 1;
		spawn_sound_absorbed();

func _on_hud_upgrade(upgrade_name):
	if upgrade_name=="max_meat":
		vac_max += 5;
