class_name ObstacleSection

extends Node2D

enum Difficulty {
	EASY,
	MEDIUM,
	HARD
}

@export var obstacles: Array[PackedScene]

@export var DIFFICULTY : Difficulty

@export var OBSTACLE_COUNT: int = 5
@export var SECTION_WIDTH: float = 2000.0

# @onready var floor_collider_shape: WorldBoundaryShape2D = $Floor/CollisionShape2D.shape
@onready var FLOOR_HEIGHT: float = $Floor/CollisionShape2D.shape.distance

func generate_obstacles( ):
	# This function will be called to generate obstacles based on the difficulty level.
	# for i in range(OBSTACLE_COUNT):
		# var obstacle = obstacles[DIFFICULTY].instance()

		# var obstacle = obstacles[randi() % obstacles.size()].instantiate()
		# add_child(obstacle)
		# obstacle.position.x = randf_range(0, SECTION_WIDTH)
		# obstacle.position.y = floor_height
		# obstacle.scale = Vector2(1, 1)
		# obstacle.connect("body_entered", self, "_on_obstacle_body_entered")
		# obstacle.connect("body_exited", self, "_on_obstacle_body_exited")
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("_regenerate_obstacles"):
		generate_obstacles()
		print("Regenerating obstacles")
		pass
