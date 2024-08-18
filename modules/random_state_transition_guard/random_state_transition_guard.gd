class_name RandomGuard
extends Guard


@export var _chance: float


func is_satisfied(context_transition: Transition, context_state: StateChartState) -> bool:
	return randf() <= _chance
