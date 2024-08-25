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

func _on_behaviour_activated() -> void:
	_start_eating()
	
func _start_eating() -> void:
	_current_corpse = _find_corpse()
	
	if _current_corpse == null:
		_animation_player.play("idle")
		deactivate()
		return
		
	_animation_player.play("eating")
	_eating_timer.start(_current_corpse.time_to_eat)


func _on_behaviour_deactivated() -> void:
	_eating_timer.stop()

#when corpse was eaten
func _on_timer_timeout() -> void:
	_character_signals.body_eaten.emit(_current_corpse.essence_count)
	
	_current_corpse.destroy_corpse()
	
	_start_eating()

func _find_corpse() -> Corpse:
	var areas_in_eating_area = _eating_area.get_overlapping_areas()
	
	for area in areas_in_eating_area:
		if area is Corpse:
			if area != _current_corpse and area.is_active:
				return area
	
	return null
