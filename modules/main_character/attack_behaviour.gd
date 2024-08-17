extends Behaviour


@export var _projectile_scene: PackedScene
@export var _projectiles_signals: ProjectilesSignals
@export var _attack_point: Node2D
@export var _attack_spawn_distance: float 


func attack() -> void:
	if not _is_active:
		return
	
	var mouse_pos = get_viewport().get_mouse_position()
	var attack_vector = _attack_point.global_position - mouse_pos
	var spawn_vector = _attack_point.global_position + attack_vector.normalized() * -_attack_spawn_distance
	
	_projectiles_signals.spawn_requested.emit(spawn_vector, Vector2.LEFT.angle_to(attack_vector), _projectile_scene)
	
