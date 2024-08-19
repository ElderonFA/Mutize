extends Node


signal moving_pressed

signal attack_pressed
signal attack_released


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("character_left")\
	or event.is_action_pressed("character_right")\
	or event.is_action_pressed("character_up")\
	or event.is_action_pressed("character_down"):
		moving_pressed.emit()
	
	if event.is_action_pressed("character_attack"):
		attack_pressed.emit()
	
	if event.is_action_released("character_attack"):
		attack_released.emit()
