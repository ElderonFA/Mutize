class_name DoorController
extends Node2D


@export var _character_signals: CharacterSignals
@export var _animation_player: AnimationPlayer
@export var spawn_point: Node2D

var is_open = false

#нужен рефактор
func _ready() -> void:
	_character_signals.evolving_requested.connect(open_door)


func open_door() -> void:
	if is_open:
		return
		
	is_open = true
	_animation_player.play("open")
