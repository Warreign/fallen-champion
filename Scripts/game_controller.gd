class_name GameController

extends Node2D

func generate_obstacles() -> void:
	return

func _process(delta: float) -> void:
	# print($Player.get_viewport_size())
	# print($Player.get_viewport_rect())
	# print($Player.position)

	# print(str($Player.get_viewport_edge_left()) + " | " + str($Player.position.x) + " | " + str($Player/Camera2D.get_screen_center_position().x) + " | " + str($Player/Camera2D.get_global_mouse_position().x) + " | " + str($Player.get_viewport_edge_right()))
	pass

func _physics_process(delta: float) -> void:
	pass
