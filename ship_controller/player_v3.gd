extends CharacterBody3D

# accumulators
var rot_x = 0
var rot_y = 0

func _input(event):
	if event is InputEventMouseMotion:
		# modify accumulated mouse rotation
		rot_x += event.relative.x * -0.01
		rot_y += event.relative.y * 0.01
		
		var relative_up = transform.basis.y;
		print(relative_up);
		
		transform.basis = Basis() # reset rotation
		rotate(relative_up, rot_x) # first rotate in Y
		rotate(Vector3(1, 0, 0), rot_y) # then rotate in X

func _process(delta):
	var input_thrust = Input.get_axis("ui_down", "ui_up");
	velocity = transform.basis.z * 30.0 * input_thrust;
	move_and_slide();
	
