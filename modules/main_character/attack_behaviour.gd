extends Behaviour


@export var _projectile_scene: PackedScene
@export var _projectiles_signals: ProjectilesSignals
@export var _attack_point: Node2D


func attack() -> void:
	if not _is_active:
		return
	
	_projectiles_signals.spawn_requested.emit(_attack_point.global_position, 3, _projectile_scene)
