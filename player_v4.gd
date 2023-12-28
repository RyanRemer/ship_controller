extends CharacterBody3D

@export var rotation_speed = 1.0;
@onready var ship_body : Node3D = $ShipBody;


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
	
	# Move Player
	var forward = ship_body.global_transform.basis.z.normalized();
	velocity = forward * Input.get_axis("ui_down", "ui_up") * 15.0;
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
