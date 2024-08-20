extends Label


@export var _character_signals: CharacterSignals


func _ready() -> void:
	_character_signals.grow_coef_chaged.connect(_refresh)


func _refresh(new_growth: float) -> void:
	text = "You have grown by %.1f" % new_growth
