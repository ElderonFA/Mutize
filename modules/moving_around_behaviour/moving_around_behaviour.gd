extends Behaviour


signal moved_to_another_position


@export var _owner: CharacterBody2D
@export var _moving_distance_distribution: Curve
@export var _ray_cast: RayCast2D

@export var _moving_speed: float = 100
@export var _target_reaching_distance: float = 10

var _target_position: Vector2
var _moving_vector: Vector2


func _on_behaviour_activated() -> void:
	_update_target_position()


func _update_target_position() -> void:
	var moving_distance = _moving_distance_distribution.sample(randf())
	var raw_moving_vector = Vector2.RIGHT.rotated(randf() * TAU) * moving_distance
	
	_ray_cast.target_position = raw_moving_vector
	_ray_cast.force_raycast_update()
	
	_moving_vector = raw_moving_vector.normalized() * _moving_speed
	
	if _ray_cast.is_colliding():
		var collision_point = _ray_cast.get_collision_point()
		_target_position = _owner.global_position + collision_point - _owner.global_position
		
		return
	
	_target_position = _owner.global_position + raw_moving_vector


func _physics_process_behaviour(delta: float) -> void:
	if (_target_position - _owner.global_position).length() <= _target_reaching_distance:
		moved_to_another_position.emit()
		
		_update_target_position()
		return
	
	_owner.velocity = _moving_vector
	_owner.move_and_slide()
