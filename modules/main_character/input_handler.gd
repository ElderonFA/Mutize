extends Node


signal moving_pressed

signal attack_pressed
signal attack_released

signal eat_pressed
signal eat_released


var _is_active: bool = true


func deactivate() -> void:
	_is_active = false


func _input(event: InputEvent) -> void:
	if not _is_active:
		return
	
	if event.is_action_pressed("character_left")\
	or event.is_action_pressed("character_right")\
	or event.is_action_pressed("character_up")\
	or event.is_action_pressed("character_down"):
		moving_pressed.emit()
	
	if event.is_action_pressed("character_attack"):
		attack_pressed.emit()
	if event.is_action_released("character_attack"):
		attack_released.emit()
		
	if event.is_action_pressed("character_eat"):
		eat_pressed.emit()
	if event.is_action_released("character_eat"):
		eat_released.emit()
