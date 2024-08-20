extends TextureProgressBar


@export var _character_signals: CharacterSignals
@export var _animation_player: AnimationPlayer


func _ready() -> void:
	_character_signals.body_eaten.connect(get_essence)


func get_essence(essence_count: int):
	value += essence_count
	
	if value >= max_value:
		_animation_player.play("show_is_full")


func after_show_is_full_anim():
	_character_signals.evolving_requested.emit()
	value = 0
