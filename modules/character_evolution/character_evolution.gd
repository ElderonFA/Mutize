class_name EvolutionBehaviour
extends Behaviour


@export var _character_signals: CharacterSignals

@export var _main_node_character: Node2D
#@export var _spite_renderer: Sprite2D
#@export var _sprite_first_level: Texture

var _current_level = 0

var _grow_coef = 0.1

func _on_behaviour_activated() -> void:
	_character_signals.evolving_requested.connect(evolve)


func evolve():
	_current_level += 1
	
	var new_scale = Vector2(_main_node_character.scale.x + _grow_coef, _main_node_character.scale.y + _grow_coef)
	_main_node_character.scale = new_scale
	
	_character_signals.grow_coef_chaged.emit(_main_node_character.scale.x)
	
	#_spite_renderer.texture = _sprite_first_level
	
	print("EVOLVE!")
