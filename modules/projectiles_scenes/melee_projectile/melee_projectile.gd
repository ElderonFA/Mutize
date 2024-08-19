extends Projectile


@export var damage_count = 10
@export var projectile_speed = 2

func _physics_process(delta: float) -> void:
	global_position += Vector2.RIGHT.rotated(global_rotation) * delta * projectile_speed


func setup(rotation: float) -> void:
	self.global_rotation = rotation


func _on_area_entered(area: Area2D) -> void:
	if area is DamageableArea2D:
		area.apply_damage(damage_count)
		_despawn()


func _despawn() -> void:
	queue_free()
