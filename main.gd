extends Node3D

@onready var player = $Player;

func _input(event):
	if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
		player.enable_rotation = true;
		player.enable_movement = true;
		
	if event.is_action_pressed("pause"):
		player.enable_rotation = false;
		player.enable_movement = false;
