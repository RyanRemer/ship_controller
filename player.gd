extends CharacterBody3D

@export var speed = 30.0;

func _process(delta):
	
	
	velocity = _get_velocity();
	move_and_slide();
	
func _get_velocity():
	var wasd = Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up");
	
	var forward = global_transform.basis.z;
	var sideway = Vector3(-forward.z, 0, forward.x);
	
	var direction = Vector3.ZERO;
	direction += forward * wasd.y;
	direction += sideway * wasd.x;
	return direction.normalized() * speed;
	
	
# Get a vector for the mouse relative to the center of the screen
# Range(-1, 1)
func _get_relative_mouse() -> Vector2:
	var viewport = get_viewport();
	var mouse_position = viewport.get_mouse_position();
	var center = viewport.size / 2.0;
	var mouse_direction = mouse_position - center;
	
	var size = min(viewport.size.x, viewport.size.y);
	return mouse_direction / size;
	
