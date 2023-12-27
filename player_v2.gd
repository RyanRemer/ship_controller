extends CharacterBody3D

var player_rotation = Vector2.ZERO;

func _process(delta):
	var relative_mouse = _get_relative_mouse();
	
	player_rotation = Vector3.ZERO
	player_rotation.x += fmod(-relative_mouse.x * delta * PI * 2.0, PI * 2.0);
	player_rotation.y += fmod(relative_mouse.y * delta * PI * 2.0, PI * 2.0);
	var basis = global_transform.basis;
	basis = basis.rotated(Vector3.UP, player_rotation.x);
	basis = basis.rotated(Vector3.RIGHT, player_rotation.y);
	basis = basis.orthonormalized();
	transform.basis = basis;
	
	var input_y = Input.get_action_strength("ui_up");
	var forward = transform.basis.z;
	velocity = forward * input_y * 30.0;
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
