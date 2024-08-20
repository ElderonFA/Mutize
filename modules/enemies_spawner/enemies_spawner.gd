extends Node2D


@export var _enemy: PackedScene

@export var _character_signals: CharacterSignals
@export var _spawner_signals: SpawnerSignals

@export var _wave_timer: Timer
@export var _spawn_timer: Timer

@export var _doors: Array[DoorController]

var _wave_spawn_delay = 2.0
var _wave_enemies_count = 3
var _current_wave_enemies_count = 0

var _random = RandomNumberGenerator.new()
var _spawn_min_delay = 1.0
var _spawn_max_delay = 2.0


func _ready() -> void:
	_character_signals.evolving_requested.connect(_start_first_wave)


func _start_first_wave():
	_character_signals.evolving_requested.disconnect(_start_first_wave)
	_start_wave_after_delay()


func _start_wave_after_delay():
	_wave_timer.start(_wave_spawn_delay)
	_wave_spawn_delay += 2


func _on_wave_timer_timeout() -> void:
	_spawner_signals.open_doors.emit()
	_spawn_timer.start(_random.randf_range(_spawn_min_delay, _spawn_max_delay))


func _on_spawn_timer_timeout() -> void:
	if _current_wave_enemies_count != _wave_enemies_count:
		var current_door = _doors.pick_random() as DoorController
		var enemy = _enemy.instantiate() as Node2D
		enemy.position = current_door.spawn_point.global_position
		add_child(enemy)
			
		_spawn_timer.start(_random.randf_range(_spawn_min_delay, _spawn_max_delay))
		_current_wave_enemies_count += 1
	else:
		_start_wave_after_delay()
		_spawner_signals.close_doors.emit()
		_current_wave_enemies_count = 0
		_wave_enemies_count += 1
