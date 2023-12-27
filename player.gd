extends CharacterBody3D

@export var speed = 30.0;

func _process(delta):
	var wasd = Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up");
	
	var forward = global_transform.basis.z;
	var sideway = Vector3(-forward.z, 0, forward.x);
	
	velocity = Vector3.ZERO;
	velocity += forward * wasd.y;
	velocity += sideway * wasd.x;
	velocity = velocity.normalized() * speed;
	
	move_and_slide();
	
	
# Get a vector for the mouse relative to the center of the screen
# Range(-1, 1)
func _get_relative_mouse() -> Vector2:
	var viewport = get_viewport();
	var mouse_position = viewport.get_mouse_position();
	var center = viewport.size / 2.0;
	var mouse_direction = mouse_position - center;
	
	var size = min(viewport.size.x, viewport.size.y);
	return mouse_direction / size;
	
