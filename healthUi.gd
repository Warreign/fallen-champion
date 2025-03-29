extends CanvasLayer

@export var full_heart: Texture  
@export var empty_heart: Texture

func update_health(current_health, max_health):
	for i in range(get_child_count()):
		var heart = get_child(i)
		if i < current_health:
			heart.texture = full_heart 
		else:
			heart.texture = empty_heart 
