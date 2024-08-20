class_name ObjectsRadar
extends Area2D


signal object_found(node: Node2D)
signal nearest_object_changed(node: Node2D)
signal object_lost


@export var _refresh_delay: float = 0.5


var _nearest_object: Node2D:
	set(new_nearest_object):
		if not _nearest_object\
		and new_nearest_object:
			object_found.emit(new_nearest_object)
		
		if _nearest_object\
		and new_nearest_object\
		and _nearest_object != new_nearest_object:
			nearest_object_changed.emit(new_nearest_object)
		
		if _nearest_object\
		and not new_nearest_object:
			object_lost.emit()
		
		_nearest_object = new_nearest_object


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
	var new_nearest_object_distance: float = INF
	var new_nearest_object: Node2D
	
	var overlapping_objects: Array
	overlapping_objects.append_array(get_overlapping_bodies())
	overlapping_objects.append_array(get_overlapping_areas())
	
	for near_object in overlapping_objects:
		var distance_to_object = (near_object.global_position - global_position)\
			.length()
		
		if distance_to_object < new_nearest_object_distance:
			new_nearest_object = near_object
			new_nearest_object_distance = distance_to_object
	
	_nearest_object = new_nearest_object
