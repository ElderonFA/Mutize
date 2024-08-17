extends CharacterBody2D


@export_group("Behaviours")
@export var _run_behaviour: Behaviour

@export_group("States")
@export var _state_chart: StateChart

@export var _idle_state: StateChartState
@export var _run_state: StateChartState


func _ready() -> void:
	_idle_state.state_entered.connect(_on_idle_state_entered)
	_idle_state.state_exited.connect(_on_idle_state_exited)
	
	_run_state.state_entered.connect(_on_run_state_entered)
	_run_state.state_exited.connect(_on_run_state_exited)


func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept"):
		#_state_chart.send_event("go_to_run")
	#
	#if event.is_action_pressed("ui_left"):
		#_state_chart.send_event("go_to_idle")
	
	if event.is_action_pressed("character_left")\
	or event.is_action_pressed("character_right")\
	or event.is_action_pressed("character_up")\
	or event.is_action_pressed("character_down"):
		_state_chart.send_event("moving_input_pressed")


func _process(delta: float) -> void:
	if velocity.length() == 0:
		_state_chart.send_event("velocity_become_zero")


func _on_idle_state_entered() -> void:
	print("idle_entered")


func _on_idle_state_exited() -> void:
	print("idle_ex")


func _on_run_state_entered() -> void:
	_run_behaviour.activate()
	print("run_entered")


func _on_run_state_exited() -> void:
	_run_behaviour.deactivate()
	print("run_ex")
