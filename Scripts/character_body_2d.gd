extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var SCALE_SPEED = 3.0
var shrank = false

var original_scale
var target_scale
var curr_speed = SPEED


func _ready() -> void:
	original_scale = scale
	target_scale = Vector2(original_scale.x * 2, original_scale.y / 2)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * (2 if shrank else 1)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# var curr_speed = SPEED

	if Input.is_action_just_pressed("slide") and is_on_floor() and not shrank:
		curr_speed = SPEED * 1.5
		shrank = true
		$SlideTimer.start()
		# original_scale = scale
	
	if shrank:
		scale = scale.lerp(target_scale, SCALE_SPEED*delta)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := 1
	if direction:
		velocity.x = direction * curr_speed
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, curr_speed)
	
	move_and_slide()


func _on_slide_timer_timeout() -> void:
	shrank = false
	scale = original_scale
	curr_speed = SPEED
