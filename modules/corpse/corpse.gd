class_name Corpse
extends Area2D


@export var time_to_eat: float = 1

var is_active = false


func _set_corpse_is_active() -> void:
	is_active = true

func _on_damageable_area_2d_dead() -> void:
	_set_corpse_is_active()

func destroy_corpse() -> void:
	get_parent().queue_free()
