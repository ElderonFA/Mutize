class_name DoorController
extends Node2D


@export var _character_signals: CharacterSignals
@export var _animation_player: AnimationPlayer
@export var spawn_point: Node2D

@export var _spawner_signals: SpawnerSignals

#нужен рефактор
func _ready() -> void:
	_spawner_signals.open_doors.connect(open_door)
	_spawner_signals.close_doors.connect(close_door)


func open_door() -> void:
	_animation_player.play("open")

func close_door() -> void:
	_animation_player.play("close")
