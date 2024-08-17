extends Projectile


@export var damage_count = 10


func setup(rotation: float) -> void:
	self.global_rotation = rotation


func _on_area_entered(area: Area2D) -> void:
	if area is DamageableArea2D:
		area.apply_damage(damage_count)
		queue_free()
