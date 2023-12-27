extends CharacterBody3D

@export var speed = 30.0;
@export var rotation_speed = 2 * PI;
var player_rotation = Vector2.ZERO;

func _process(delta):
	_rotate_player(delta);
	velocity = _get_velocity();
	move_and_slide();
	
func _rotate_player(delta):
	var relative_mouse := _get_relative_mouse();
	
	player_rotation.x += fmod(-relative_mouse.x * rotation_speed * delta, 2 * PI);
	player_rotation.y += fmod(relative_mouse.y * rotation_speed * delta, 2 * PI);
	
	var basis = Basis.IDENTITY;
	basis = basis.rotated(Vector3.RIGHT, player_rotation.y);
	basis = basis.rotated(Vector3.UP, player_rotation.x);
	global_transform.basis = basis;
	
func _get_velocity():
	var wasd = Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up");
	
	var forward = global_transform.basis.z;
	var sideway = Vector3(-forward.z, 0, forward.x);
	
	var direction = Vector3.ZERO;
	direction += forward * wasd.y;
	direction += sideway * wasd.x;
	return direction.normalized() * speed;
	
# Get a vector for the mouse relative to the center of the screen
# Range(-1, 1) negative is left/top positive is right/bottom
func _get_relative_mouse() -> Vector2:
	var viewport = get_viewport();
	var mouse_position = viewport.get_mouse_position();
	var center = viewport.size / 2.0;
	var mouse_direction = mouse_position - center;
	
	var size = max(viewport.size.x, viewport.size.y);
	return mouse_direction / size;
	
