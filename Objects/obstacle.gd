class_name Obstacle

extends Area2D

@export var height_scale: float:
	set(value):
		height_scale = value
		if is_node_ready():
			set_new_height(value)
	get:
		return height_scale

@onready var patch_rect: NinePatchRect = $NinePatchRect
@onready var collider_shape: RectangleShape2D = $CollisionShape2D.shape

@onready var PATCH_BASE_HEIGHT: float = patch_rect.patch_margin_top + patch_rect.patch_margin_bottom
@onready var COLLIDER_BASE_HEIGHT: float = collider_shape.size.y

func set_new_height(new_height: float):
	print("New height " + str(new_height))

	var old_patch_rect = patch_rect.get_rect()
	var old_collider_rect = collider_shape.get_rect()

	var new_patch_rect = Rect2(old_patch_rect)
	new_patch_rect.size.y = PATCH_BASE_HEIGHT * height_scale
	patch_rect.set_region_rect(new_patch_rect)

	collider_shape.size.y = COLLIDER_BASE_HEIGHT * height_scale

func _on_body_entered(body: Node) -> void:
	if body is Player:
		(body as Player).hit(position.x)
		print("Player hit")

func _input(event: InputEvent) -> void:
	if (event is InputEventKey) && !event.is_echo():
		var key_event = event as InputEventKey
		var event_keycode = key_event.keycode
		if key_event.pressed && (event_keycode >= KEY_0) && (event_keycode <= KEY_9):
			var num: int = event_keycode - KEY_0
			height_scale = 1 + num * 0.1