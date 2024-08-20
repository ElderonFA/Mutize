extends Behaviour


signal attacking_finished


@export var _animation_player: AnimationPlayer


var _target: Node2D


func _ready() -> void:
	_animation_player.animation_finished.connect(_on_animation_finished)


func set_target(target: Node2D) -> void:
	_target = target


func clear_target() -> void:
	_target = null


func apply_damage_to_target() -> void:
	if not _is_active\
	or not _target\
	or _target is not DamageableArea2D:
		return
	
	_target.apply_damage(1)


func _on_behaviour_activated() -> void:
	_start_attacking()


func _start_attacking() -> void:
	_animation_player.play("attack")


func _on_animation_finished(animation_name: String) -> void:
	if not _is_active\
	or animation_name != "attack":
		return
	
	if _target:
		_start_attacking()
	
	else:
		attacking_finished.emit()
