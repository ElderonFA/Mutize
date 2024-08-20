extends Behaviour


@export var _animation_player: AnimationPlayer
@export var _behaviours_for_onoff: Array[Behaviour]
@export var _eating_timer: Timer
@export var _state_chart: StateChart

@export var _character_signals: CharacterSignals

var _current_corpse: Corpse


func start_eating() -> void:
	if _current_corpse == null:
		_eating_timer.stop()
		_state_chart.send_event("eating_ended")
		return
		
	_animation_player.play("eating")
	_eating_timer.start(_current_corpse.time_to_eat)
	
	for behaviour in _behaviours_for_onoff:
		behaviour.deactivate()


func stop_eating() -> void:
	_eating_timer.stop()
	_state_chart.send_event("eating_ended")
	_animation_player.play("idle")
	
	for behaviour in _behaviours_for_onoff:
		behaviour.activate()


func _on_eating_area_area_entered(area: Area2D) -> void:
	if area is Corpse:
		_current_corpse = area


func _on_eating_area_area_exited(area: Area2D) -> void:
	if area is Corpse and _current_corpse == area:
		_current_corpse = null


#when corpse was eaten
func _on_timer_timeout() -> void:
	if _current_corpse == null:
		return
	
	_character_signals.body_eaten.emit(_current_corpse.essence_count)
	
	_current_corpse.destroy_corpse()
	_state_chart.send_event("eating_ended")
	_animation_player.play("idle")


func _on_input_handler_eat_pressed() -> void:
	start_eating()


func _on_input_handler_eat_released() -> void:
	stop_eating()
