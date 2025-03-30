extends ProgressBar

signal the_end

var sb

var colorRed = Color("ff0000")
var colorOrange = Color("e8680f")
var colorGreen = Color("00ff00")

func _ready() -> void:
	sb = StyleBoxFlat.new()
	$".".add_theme_stylebox_override("fill", sb)
	sb.bg_color = colorRed
	$".".max_value = $DopingTimer.wait_time
	$DopingTimer.start(0.1)

func _process(delta: float) -> void:
	var wt = $".".max_value
	var tl = $DopingTimer.time_left
	
	if Input.is_action_just_pressed("doping"):
		$DopingTimer.start(tl+wt/3)
		tl = $DopingTimer.time_left
	
	if tl >= wt:
		the_end.emit()
	
	$".".value = tl
	
	if tl < wt/2:
		#red
		sb.bg_color = colorOrange.lerp(colorGreen, ((wt/2-tl)/(wt/2)))
		#sb.bg_color = colorOrange
	else:
		#green
		sb.bg_color = colorRed.lerp(colorOrange, (wt-tl)/(wt/2))
		#sb.bg_color = colorGreen
