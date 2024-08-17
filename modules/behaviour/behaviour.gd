class_name Behaviour
extends Node


var _is_active: bool


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


func _process_behaviour(delta: float) -> void:
	pass


func _physics_process_behaviour(delta: float) -> void:
	pass
