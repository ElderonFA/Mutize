extends Behaviour


@export var behaviours_for_deactivate: Array[Behaviour]


func _on_behaviour_activated() -> void:
	for behaviour in behaviours_for_deactivate:
		behaviour.deactivate()
