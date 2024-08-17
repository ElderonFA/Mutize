extends StateChart


@export_group("Behaviours")
@export var _run_behaviour: Behaviour
@export var _attack_behaviour: Behaviour


@export_group("States")
@export var _idle_state: StateChartState
@export var _run_state: StateChartState
@export var _attack_state: StateChartState


func _ready() -> void:
	super._ready()
	
	_idle_state.state_entered.connect(_on_idle_state_entered)
	_idle_state.state_exited.connect(_on_idle_state_exited)
	
	_run_state.state_entered.connect(_on_run_state_entered)
	_run_state.state_exited.connect(_on_run_state_exited)
	
	_attack_state.state_entered.connect(_on_attack_state_entered)
	_attack_state.state_exited.connect(_on_attack_state_exited)


func _on_idle_state_entered() -> void:
	print("idle_entered")


func _on_idle_state_exited() -> void:
	print("idle_ex")


func _on_run_state_entered() -> void:
	_run_behaviour.activate()


func _on_run_state_exited() -> void:
	_run_behaviour.deactivate()
	
	
func _on_attack_state_entered() -> void:
	_attack_behaviour.activate()
	
func _on_attack_state_exited() -> void:
	_attack_behaviour.deactivate()
