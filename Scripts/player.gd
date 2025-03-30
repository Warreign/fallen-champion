class_name Player

extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -600.0
@export var SCALE_SPEED = 3.0

var direction := 1

@export var is_running = false
var is_shrank := false
var is_dying := false
var is_midair := false
var is_falling := false
var is_jumping := false

var original_height
var target_height

var original_scale
var target_scale
var curr_speed = SPEED

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var shape: CapsuleShape2D = $Colca.shape

func get_viewport_edge_left():
	return $Camera2D.get_screen_center_position().x - ($Camera2D.get_viewport_rect().size.x / $Camera2D.get_zoom().x ) / 2

func get_viewport_edge_right():
	return $Camera2D.get_screen_center_position().x + $Camera2D.get_viewport_rect().size.x / $Camera2D.get_zoom().x / 2

func hit(position_x: float):
	is_falling = true
	direction = -1
	animated_sprite.play("hit")
	$HitTimer.start()
	print("Hit obstacle")

func die():
	animated_sprite.play("die")
	is_dying = true
	$DieTimer.start()

func _ready() -> void:
	original_scale = $Colca.scale
	target_scale = Vector2(original_scale.x, original_scale.y / 2)
	original_height = shape.height
	target_height = original_height / 2 
	animated_sprite.play("idle")

func _process(delta: float) -> void:
	# print(get_gravity())
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.

	if not is_on_floor():
		velocity += get_gravity() * delta * (2 if is_shrank else 1)

	if is_shrank:
		# $Colca.scale = $Colca.scale.lerp(target_scale, SCALE_SPEED*delta)
		shape.height = lerp(shape.height, target_height, SCALE_SPEED * delta)
		# shape.height = $Colca.scale.y * 2

	if is_dying or is_falling:
		curr_speed = lerp(curr_speed, 0.0, SCALE_SPEED * delta)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity.x = direction * curr_speed

	if is_running:
		move_and_slide()

	if is_on_floor():
		if is_midair:
			print("landed")
			animated_sprite.play("running")
		is_midair = false


func _on_die_timer_timeout() -> void:
	is_running = false
	is_dying = false

func _on_slide_timer_timeout() -> void:
	is_shrank = false
	# $Colca.scale = original_scale
	shape.height = original_height
	curr_speed = SPEED
	animated_sprite.play("running")

func _on_hit_timer_timeout() -> void:
	direction = 1;
	animated_sprite.play("idle")
	is_running = false
	is_falling = false;
	print("Fell")

func _input(event: InputEvent) -> void:
	if !is_running and event.is_action_pressed("run"):
		curr_speed = SPEED
		animated_sprite.play("running")
		is_running = true

	
	if is_running and event.is_action_pressed("slide") and is_on_floor() and not is_shrank:
		# curr_speed = SPEED * 1.5
		is_shrank = true
		$SlideTimer.start()
		animated_sprite.play("slide")
		# original_scale = scale
	
	# Handle jump.
	if event.is_action_pressed("jump"):
		is_jumping = true
		if is_running and is_on_floor():
			print("jumped")
			animated_sprite.play("jump")
			is_midair = true
			velocity.y = JUMP_VELOCITY

	if event.is_action_released("jump"):
		is_jumping = false

	if event.is_action_pressed("_die"):
		die()

	if event.is_action_pressed("_hit"):
		print("Hit action")
		hit(position.x)
