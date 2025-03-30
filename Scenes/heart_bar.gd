class_name HeartBar

extends TextureProgressBar

signal player_died

func decrement_hearts() -> void:
    if value > 0:
        value -= 1
    else:
        print("Game Over")
        player_died.emit()