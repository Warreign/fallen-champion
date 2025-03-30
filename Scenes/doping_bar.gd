class_name DopingBar

extends ProgressBar

signal doping_full

var sb

var colorRed = Color("ff0000")
var colorOrange = Color("e8680f")
var colorGreen = Color("00ff00")

func _ready() -> void:
	sb = StyleBoxFlat.new()
	add_theme_stylebox_override("fill", sb)
	sb.bg_color = colorRed
	max_value = $DopingTimer.wait_time
	$DopingTimer.start(0.1)

func _process(delta: float) -> void:
	if $DopingTimer.is_stopped():
		return

	var wt = max_value
	var tl = $DopingTimer.time_left
	
	if tl >= wt:
		$DopingTimer.stop()
		doping_full.emit()
	
	value = tl
	
	if tl < wt/2:
		#red
		sb.bg_color = colorOrange.lerp(colorGreen, ((wt/2-tl)/(wt/2)))
		#sb.bg_color = colorOrange
	else:
		#green
		sb.bg_color = colorRed.lerp(colorOrange, (wt-tl)/(wt/2))
		#sb.bg_color = colorGreen

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("doping"):
		var wt = max_value
		var tl = $DopingTimer.time_left
		$DopingTimer.start(tl+wt/3)
		tl = $DopingTimer.time_left
