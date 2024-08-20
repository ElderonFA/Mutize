extends TextureProgressBar


@export var _character_signals: CharacterSignals


func _ready() -> void:
	_character_signals.health_changed.connect(_on_character_health_changed)
	_character_signals.max_health_changed.connect(_on_character_max_health_changed)
	
	_character_signals.evolving_requested.connect(show)


func _on_character_health_changed(new_value: int) -> void:
	value = new_value


func _on_character_max_health_changed(new_value: int) -> void:
	max_value = new_value
