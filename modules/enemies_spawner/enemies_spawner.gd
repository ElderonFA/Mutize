extends Node2D


@export var _enemy: PackedScene

@export var _character_signals: CharacterSignals
@export var _wave_timer: Timer
@export var _spawn_timer: Timer

@export var _doors: Array[DoorController]

var wave_spawn_delay = 2.0
var wave_enemies_count = 3

var random = RandomNumberGenerator.new()
var spawn_min_delay = 3.0
var spawn_max_delay = 5.0


func _ready() -> void:
	_character_signals.evolving_requested.connect(start_wave_after_delay)


func start_wave_after_delay():
	_wave_timer.start(wave_spawn_delay)
	wave_spawn_delay += 5


func _on_wave_timer_timeout() -> void:
	_spawn_timer.start(random.randf_range(spawn_min_delay, spawn_max_delay))


func _on_spawn_timer_timeout() -> void:
	for i in range(wave_enemies_count):
		var current_door = _doors.pick_random() as DoorController
		var enemy = _enemy.instantiate() as Node2D
		enemy.position = current_door.spawn_point.global_position
		add_child(enemy)
		
	_spawn_timer.start(random.randf_range(spawn_min_delay, spawn_max_delay))
	
	wave_enemies_count += 1
