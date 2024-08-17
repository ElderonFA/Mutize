class_name RunBehaviour
extends Behaviour


@export var _owner: CharacterBody2D
@export var _move_speed: float = 300


func _physics_process_behaviour(delta: float) -> void:
	var input_vector = Input\
		.get_vector("character_left", "character_right", "character_up", "character_down")
	
	_owner.velocity = input_vector.normalized() * _move_speed
	_owner.move_and_slide()
