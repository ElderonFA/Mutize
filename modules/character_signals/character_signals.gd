class_name CharacterSignals
extends Resource


signal body_eaten(essence_count: int)
signal grow_coef_chaged(new_coef: float)

signal health_changed(new_value: int)
signal max_health_changed(new_value: int)

signal evolving_requested()

signal died
