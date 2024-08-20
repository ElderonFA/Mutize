extends Behaviour


@export var _owner: CharacterBody2D
@export var _moving_speed: float

var _subject: Node2D


func set_subject(subject: Node2D) -> void:
	_subject = subject


func clear_subject() -> void:
	_subject = null


func _physics_process_behaviour(delta: float) -> void:
	if not _subject:
		return
	
	_owner.velocity = (_subject.global_position - _owner.global_position)\
		.normalized() * _moving_speed
	_owner.move_and_slide()
