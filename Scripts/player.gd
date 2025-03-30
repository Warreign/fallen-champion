class_name Player

extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var SCALE_SPEED = 3.0
@export var is_running = false
var shrank = false

var original_height
var target_height

var original_scale
var target_scale
var curr_speed = SPEED

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var shape: CapsuleShape2D = $Colca.shape


func _ready() -> void:
	original_scale = $Colca.scale
	target_scale = Vector2(original_scale.x, original_scale.y / 2)
	original_height = shape.height
	target_height = original_height
	animated_sprite.play("idle")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * (2 if shrank else 1)

	if shrank:
		# $Colca.scale = $Colca.scale.lerp(target_scale, SCALE_SPEED*delta)
		shape.height = lerp(shape.height, target_height, SCALE_SPEED * delta)
		# shape.height = $Colca.scale.y * 2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := 1
	if direction:
		velocity.x = direction * curr_speed
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, curr_speed)
	
	if is_running:
		move_and_slide()


func _on_slide_timer_timeout() -> void:
	shrank = false
	# $Colca.scale = original_scale
	shape.height = original_height
	curr_speed = SPEED
	animated_sprite.play("running")
	

func _input(event: InputEvent) -> void:
	if !is_running && event.is_action_pressed("run"):
		animated_sprite.play("running")
		is_running = true

	
	if event.is_action_pressed("slide") and is_on_floor() and not shrank:
		# curr_speed = SPEED * 1.5
		shrank = true
		$SlideTimer.start()
		animated_sprite.play("slide")
		# original_scale = scale
	
	# Handle jump.
	if event.is_action_pressed("jump") and is_on_floor():
		animated_sprite.play("jump")
		velocity.y = JUMP_VELOCITY


	
