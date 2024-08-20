extends CharacterBody2D


@export var _character_signals: CharacterSignals


func die() -> void:
	_character_signals.died.emit()
