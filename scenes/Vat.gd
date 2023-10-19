extends Node3D

@onready var liquidMesh: MeshInstance3D = $Liquid
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal full;
var currentAmount = -4.00;

var fillPercentage = 0;

func dump():
	currentAmount = -4.0;
	animation_player.play("Drain");

func increase_liquid(amount: float):
	
	var shaderMat: ShaderMaterial = liquidMesh.get_active_material(0);
	currentAmount = currentAmount+amount
	if (currentAmount < 4.0):
		shaderMat.set_shader_parameter("liquid_height", currentAmount);
	else:
		full.emit();

func _ready():
	var shaderMat: ShaderMaterial = liquidMesh.get_active_material(0);
	shaderMat.set_shader_parameter("liquid_height", currentAmount)



func _process(delta):
	
	pass
