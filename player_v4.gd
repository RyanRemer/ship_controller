extends CharacterBody3D

@export var rotation_speed = 1.0;

func _process(delta):
	var basis = transform.basis;
	
	var relative_mouse = _get_relative_mouse();
	
	basis = basis.rotated(basis.y, PI * delta);
	
	transform.basis = basis;

# Get a vector for the mouse relative to the center of the screen
# Range(-1, 1) negative is left/top positive is right/bottom
func _get_relative_mouse() -> Vector2:
	var viewport = get_viewport();
	var mouse_position = viewport.get_mouse_position();
	var center = viewport.size / 2.0;
	var mouse_direction = mouse_position - center;
	
	var size = max(viewport.size.x, viewport.size.y);
	return mouse_direction / size;
