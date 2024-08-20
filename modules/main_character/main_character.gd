extends CharacterBody2D


@export var _character_signals: CharacterSignals
@export var _damageable_area: DamageableArea2D


func _ready() -> void:
	_character_signals.max_health_changed.emit(_damageable_area.get_max_health())
	_character_signals.max_health_changed.emit(_damageable_area.get_health())
	
	_damageable_area.damaged.connect(_on_damaged)
	_damageable_area.dead.connect(_on_died)


func _on_died() -> void:
	_character_signals.died.emit()


func _on_damaged() -> void:
	_character_signals.health_changed.emit(_damageable_area.get_health())
