extends StateChart


@export var _danger_radar: ObjectsRadar
@export var _attack_zone: ObjectsRadar
@export var _animation_setter: AnimationSetter

@export_group("Behaviours")
@export var _moving_around_behaviour: Behaviour
@export var _wait_behaviour: Behaviour
@export var _move_to_danger_behaviour: Behaviour
@export var _attacking_behaviour: Behaviour
@export var _die_behaviour: Behaviour

@export_group("States")
@export_subgroup("Activity")
@export var _inactive_state: StateChartState
@export var _active_state: StateChartState
@export var _die_state: StateChartState
@export_subgroup("Passive")
@export var _idle_state: StateChartState
@export var _moving_around_state: StateChartState
@export_subgroup("Aggressive")
@export var _running_to_danger_state: StateChartState
@export var _attacking_state: StateChartState
@export_subgroup("Common")
@export var _recovery_after_hit_state: StateChartState
@export var _dying_state: StateChartState


func _ready() -> void:
	super._ready()
	
	# behaviours
	_danger_radar.object_found.connect(_on_danger_found)
	_danger_radar.object_lost.connect(_on_danger_lost)
	
	_attack_zone.object_found.connect(_on_attack_target_approached)
	
	# states
	# passive
	_moving_around_state.state_entered.connect(_moving_around_behaviour.activate)
	_moving_around_state.state_entered.connect(_animation_setter.play_run_anim)
	_moving_around_state.state_exited.connect(_moving_around_behaviour.deactivate)
	
	_idle_state.state_entered.connect(_wait_behaviour.activate)
	_idle_state.state_entered.connect(_animation_setter.play_idle_anim)
	_idle_state.state_exited.connect(_wait_behaviour.deactivate)
	
	# aggressive
	_attacking_state.state_entered.connect(_attacking_behaviour.activate)
	_attacking_state.state_exited.connect(_attacking_behaviour.deactivate)
	
	_running_to_danger_state.state_entered.connect(_move_to_danger_behaviour.activate)
	_running_to_danger_state.state_entered.connect(_animation_setter.play_run_panic_anim)
	_running_to_danger_state.state_exited.connect(_move_to_danger_behaviour.deactivate)
	
	#dead
	_die_state.state_entered.connect(_animation_setter.play_die_anim)


func _on_danger_found(danger: Node2D) -> void:
	send_event("danger_found")


func _on_danger_lost() -> void:
	send_event("danger_lost")


func _on_attack_target_approached(target: Node2D) -> void:
	send_event("attack_target_approached")


func _on_attack_target_moved_away() -> void:
	send_event("attack_target_moved_away")


func _on_damageable_area_2d_dead() -> void:
	send_event("die")
