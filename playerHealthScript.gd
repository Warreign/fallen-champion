extends CharacterBody2D

@onready var health_bar = $"../HealthUI/TextureProgressBar"

var health = 10

func _ready():
	update_health_ui()

func take_damage(amount):
	health = max(health - amount, 0)
	update_health_ui()
	if health == 0:
		die()

func heal(amount):
	health = min(health + amount, 10)
	update_health_ui()

func update_health_ui():
	health_bar.value = health  #

func die():
	queue_free() 

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			take_damage(2)  
			print("мінус хп ", health)
			if  health == 0:
				print("ти вмер вонючка")
			
	if event is InputEventKey and  event.pressed:
		if event.keycode == KEY_SPACE:
			heal(2) 
			print("хилка ", health)
