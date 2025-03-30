class_name ObstacleSection

extends Node2D

enum Difficulty {
	EASY,
	MEDIUM,
	HARD
}

@export var obstacle_scenes: Array[PackedScene]
var obstacle_instances: Array[Obstacle] = []

@export var DIFFICULTY : Difficulty

@export var OBSTACLE_COUNT: int = 10
@export var SECTION_WIDTH: float = 2000.0

# @onready var floor_collider_shape: WorldBoundaryShape2D = $Floor/CollisionShape2D.shape
@onready var FLOOR_HEIGHT: float = $Floor/CollisionShape2D.shape.distance

func generate_start(player_pos: float):
	return 0

func update_obstacles(left : float, right: float) -> void:
	for obs in obstacle_instances:
		if obs.position.x < left:
			obs.que
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("_regenerate_obstacles"):
		# generate_obstacles()
		print("Regenerating obstacle_scenes")
		pass
