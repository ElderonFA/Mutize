extends Node2D


@export var _projectiles_signals: ProjectilesSignals


func _ready() -> void:
	_projectiles_signals.spawn_requested.connect(_spawn_projectile)
	
	
func _spawn_projectile(position: Vector2, rotation: float, scene: PackedScene) -> void:
	var new_projectile = scene.instantiate() as Projectile
	
	new_projectile.setup(rotation)
	new_projectile.global_position = position
	
	add_child(new_projectile)
