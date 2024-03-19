extends CharacterBody3D

@export var max_speed = 20.0;
@export var acceleration = 20.0;

@onready var ship_body : Node3D = $ShipBody;
const BACKWARD_RATIO = 0.5;

var speed = 0;
var drift_direction = Vector3.FORWARD;

func _process(delta):
	# Rotate Player
	var relative_mouse = _get_relative_mouse();
	var basis = transform.basis;
	basis = basis.rotated(basis.x, relative_mouse.y * PI * delta);
	basis = basis.rotated(basis.y, -relative_mouse.x * PI * delta);
	basis = basis.orthonormalized();
	transform.basis = basis;
	
	var ship_basis = Basis.IDENTITY;
	var scale = ship_body.scale;
	ship_basis = ship_basis.rotated(Vector3.UP, -relative_mouse.x * PI / 2.0);
	ship_basis = ship_basis.rotated(Vector3.RIGHT, relative_mouse.y * PI);
	ship_basis = ship_basis.rotated(ship_basis.z, relative_mouse.x * PI);
	ship_basis = ship_basis.orthonormalized();
	ship_body.basis = ship_basis;
	ship_body.scale = scale;
	
	if Input.is_action_just_pressed("ui_drift"):
		drift_direction = transform.basis.z;
	
	if Input.is_action_pressed("ui_drift"):
		_drifting_movement(delta);
	else:
		_normal_movement(delta);
	
func _drifting_movement(delta):
	var forward = ship_body.global_transform.basis.z.normalized();
	drift_direction = drift_direction.lerp(forward, 0.5 * delta);
	
	velocity = drift_direction.normalized() * speed;
	move_and_slide();
	
func _normal_movement(delta):
	var forward = ship_body.global_transform.basis.z.normalized();
	if Input.is_action_pressed("ui_up"):
		speed = min(speed + acceleration * delta, max_speed);
	elif Input.is_action_pressed("ui_down"):
		speed = max(speed - acceleration * delta, -max_speed * BACKWARD_RATIO);
	else:
		speed -= speed * delta;
	
	velocity = forward * speed;
	move_and_slide();

# Get a vector for the mouse relative to the center of the screen
# Range(-1, 1) negative is left/top positive is right/bottom
func _get_relative_mouse() -> Vector2:
	var viewport = get_viewport();
	var mouse_position = viewport.get_mouse_position();
	var center = viewport.size / 2.0;
	var mouse_direction = mouse_position - center;
	
	var size = max(viewport.size.x, viewport.size.y);
	return mouse_direction / size;
