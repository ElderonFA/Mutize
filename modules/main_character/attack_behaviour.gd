extends Behaviour


@export var _projectile_scene: PackedScene
@export var _projectiles_signals: ProjectilesSignals
@export var _attack_point: Node2D
@export var _attack_spawn_distance: float

@export var _attack_delay: float = 1.0


var _is_attacking: bool
var _attack_delay_timer: Timer


func _ready() -> void:
	_attack_delay_timer = Timer.new()
	_attack_delay_timer.one_shot = true
	_attack_delay_timer.wait_time = _attack_delay
	
	add_child(_attack_delay_timer)
	_attack_delay_timer.timeout.connect(_on_attack_delay_timeout)


func start_attacking() -> void:
	if not _is_active:
		return
	
	_is_attacking = true
	if _attack_delay_timer.time_left == 0:
		_attack()
		_attack_delay_timer.start()


func stop_attacking() -> void:
	_is_attacking = false


func _on_behaviour_deactivated() -> void:
	stop_attacking()


func _attack() -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var attack_vector = _attack_point.global_position - mouse_pos
	var spawn_vector = _attack_point.global_position + attack_vector.normalized() * -_attack_spawn_distance
	
	_projectiles_signals.spawn_requested.emit(spawn_vector, Vector2.LEFT.angle_to(attack_vector), _projectile_scene)


func _on_attack_delay_timeout() -> void:
	if _is_attacking:
		_attack()
		_attack_delay_timer.start()
