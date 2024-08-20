extends PanelContainer


@export var _character_signals: CharacterSignals


func _ready() -> void:
	_character_signals.died.connect(show)
