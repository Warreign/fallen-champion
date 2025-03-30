extends Node

@onready var jump: AudioStreamPlayer = $Jump
@onready var hit: AudioStreamPlayer = $Hit
@onready var doping_taken: AudioStreamPlayer = $DopingTaken
@onready var slide: AudioStreamPlayer = $Slide
@onready var background_music: AudioStreamPlayer = $BackgroundMusic

func _on_background_music_finished() -> void:
	background_music.play()
