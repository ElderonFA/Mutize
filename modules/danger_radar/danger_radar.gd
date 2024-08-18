class_name DangerRadar
extends Area2D


signal danger_found(node: Node2D)
signal nearest_danger_changed(node: Node2D)
signal danger_lost


@export var _refresh_delay: float = 0.5


var _nearest_danger: Node2D:
	set(new_nearest_danger):
		if not _nearest_danger\
		and new_nearest_danger:
			danger_found.emit(new_nearest_danger)
		
		if _nearest_danger\
		and new_nearest_danger\
		and _nearest_danger != new_nearest_danger:
			nearest_danger_changed.emit(new_nearest_danger)
		
		if _nearest_danger\
		and not new_nearest_danger:
			danger_lost.emit()
		
		_nearest_danger = new_nearest_danger


func _ready() -> void:
	area_entered.connect(_refresh.unbind(1))
	area_exited.connect(_refresh.unbind(1))
	body_entered.connect(_refresh.unbind(1))
	body_exited.connect(_refresh.unbind(1))
	
	_create_refresh_timer()


func _create_refresh_timer() -> void:
	var refresh_timer = Timer.new()
	refresh_timer.one_shot = false
	refresh_timer.wait_time = _refresh_delay
	
	add_child(refresh_timer)
	
	refresh_timer.timeout.connect(_refresh)
	refresh_timer.start()


func _refresh() -> void:
	var new_nearest_danger_distance: float = INF
	var new_nearest_danger: Node2D
	
	var overlapping_objects: Array
	overlapping_objects.append_array(get_overlapping_bodies())
	overlapping_objects.append_array(get_overlapping_areas())
	
	for near_object in overlapping_objects:
		var distance_to_object = (near_object.global_position - global_position)\
			.length()
		
		if distance_to_object < new_nearest_danger_distance:
			new_nearest_danger = near_object
			new_nearest_danger_distance = distance_to_object
	
	_nearest_danger = new_nearest_danger
