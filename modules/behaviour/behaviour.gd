class_name Behaviour
extends Node


var _is_active: bool:
	set(v):
		_is_active = v
		
		if _is_active:
			_on_behaviour_activated()
		
		else:
			_on_behaviour_deactivated()


func activate() -> void:
	_is_active = true


func deactivate() -> void:
	_is_active = false


func _process(delta: float) -> void:
	if not _is_active:
		return
	
	_process_behaviour(delta)


func _physics_process(delta: float) -> void:
	if not _is_active:
		return
	
	_physics_process_behaviour(delta)


func _on_behaviour_activated() -> void:
	pass


func _on_behaviour_deactivated() -> void:
	pass


func _process_behaviour(delta: float) -> void:
	pass


func _physics_process_behaviour(delta: float) -> void:
	pass
