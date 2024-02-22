class_name Flames extends Node3D

@export_range(0.0, 1.0) var speed_ratio = 0.0;
@export var flame_color = Color.from_string("00fff7", Color.WHITE):
	set(color):
		flame_color = color;
		flame_mesh.material_override.albedo_color = flame_color;
		
@onready var flame_mesh = $FlameMesh;
		
var _scale;

func _ready():
	_scale = scale;
	
func _process(delta):
	scale = _scale * speed_ratio;
	
