extends Behaviour

@export_group("Player nodes")
@export var _animation_player: AnimationPlayer
@export var _eating_area: Area2D
@export var _eating_timer: Timer

@export var _state_chart: StateChart
@export var _character_signals: CharacterSignals

@export_group("Behaviors for on-off")
@export var _behaviours_for_onoff: Array[Behaviour]

var _current_corpse: Corpse


func start_eating() -> void:
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

#when corpse was eaten
func _on_timer_timeout() -> void:	
	_character_signals.body_eaten.emit(_current_corpse.essence_count)
	
	_current_corpse.destroy_corpse()
	_state_chart.send_event("eating_ended")
	_animation_player.play("idle")


func _on_input_handler_eat_pressed() -> void:
	_try_get_corpse()
	
	if _current_corpse == null:
		return
	
	start_eating()


func _on_input_handler_eat_released() -> void:
	stop_eating()

func _try_get_corpse() -> void:
	var areas_in_eationg_area = _eating_area.get_overlapping_areas()
	
	for area in areas_in_eationg_area:
		if area is Corpse:
			if area.is_active:
				_current_corpse = area
				return
	
	_current_corpse = null
