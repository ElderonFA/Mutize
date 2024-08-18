extends Behaviour


signal wait_timeout


@export var _time_amount_distribution: Curve

var _timer: Timer


func _ready() -> void:
	_timer = Timer.new()
	_timer.one_shot = true
	add_child(_timer)
	
	_timer.timeout.connect(_on_timer_timeout)


func _on_behaviour_activated() -> void:
	var time_amount = _time_amount_distribution.sample(randf())
	_timer.start(time_amount)


func _on_behaviour_deactivated() -> void:
	_timer.stop()


func _on_timer_timeout() -> void:
	if _is_active:
		wait_timeout.emit()
