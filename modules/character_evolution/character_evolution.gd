class_name EvolutionBehaviour
extends Behaviour


@export var _character_signals: CharacterSignals


func _on_behaviour_activated() -> void:
	_character_signals.has_essence_for_evolve.connect(evolve)


func evolve():
	print("EVOLVE!")
