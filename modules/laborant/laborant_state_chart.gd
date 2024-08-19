extends StateChart


@export var _danger_radar: DangerRadar
@export var _animation_setter: AnimationSetter

@export_group("Behaviours")
@export var _moving_around_behaviour: Behaviour
@export var _wait_behaviour: Behaviour
@export var _chaotic_running_behaviour: Behaviour
@export var _worrying_wait_behaviour: Behaviour
@export var _move_from_danger_behaviour: Behaviour

@export_group("States")
@export_subgroup("Activity")
@export var _inactive_state: StateChartState
@export var _active_state: StateChartState
@export_subgroup("Normal")
@export var _idle_state: StateChartState
@export var _moving_around_state: StateChartState
@export_subgroup("Scared")
@export var _worrying_state: StateChartState
@export var _running_from_danger_state: StateChartState
@export var _chaotic_running_state: StateChartState
@export_subgroup("Common")
@export var _recovery_after_hit_state: StateChartState
@export var _dying_state: StateChartState


func _ready() -> void:
	super._ready()
	
	# behaviours
	_danger_radar.danger_found.connect(_on_danger_found)
	_danger_radar.danger_lost.connect(_on_danger_lost)
	
	# states
	# normal
	_moving_around_state.state_entered.connect(_moving_around_behaviour.activate)
	_moving_around_state.state_entered.connect(_animation_setter.play_run_anim)
	_moving_around_state.state_exited.connect(_moving_around_behaviour.deactivate)
	
	_idle_state.state_entered.connect(_wait_behaviour.activate)
	_idle_state.state_entered.connect(_animation_setter.play_idle_anim)
	_idle_state.state_exited.connect(_wait_behaviour.deactivate)
	
	# scared
	_chaotic_running_state.state_entered.connect(_chaotic_running_behaviour.activate)
	_chaotic_running_state.state_entered.connect(_animation_setter.play_run_anim)
	_chaotic_running_state.state_exited.connect(_chaotic_running_behaviour.deactivate)
	
	_worrying_state.state_entered.connect(_worrying_wait_behaviour.activate)
	_worrying_state.state_entered.connect(_animation_setter.play_idle_anim)
	_worrying_state.state_exited.connect(_worrying_wait_behaviour.deactivate)
	
	_running_from_danger_state.state_entered.connect(_move_from_danger_behaviour.activate)
	_running_from_danger_state.state_entered.connect(_animation_setter.play_run_panic_anim)
	_running_from_danger_state.state_exited.connect(_move_from_danger_behaviour.deactivate)


func _on_danger_found(danger: Node2D) -> void:
	send_event("danger_found")


func _on_danger_lost() -> void:
	send_event("danger_lost")
