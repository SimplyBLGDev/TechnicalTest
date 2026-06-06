class_name VisionCone
extends Node2D

# Remember that both PhysicsBody2D and TileMapLayers can be detected as bodies,
# so the proper common type of the signal return type is Node2D
signal body_entered(body: Node2D)
signal body_exited(body: Node2D)

@export var color: Color
@export var border_color: Color
@export_custom(PROPERTY_HINT_NONE, "suffix:px") var border_width := 2.0
@export_custom(PROPERTY_HINT_NONE, "radians_as_degrees,suffix:º") var starting_angle := -PI * 0.25
@export_custom(PROPERTY_HINT_NONE, "radians_as_degrees,suffix:º") var angle_amplitude := PI * 0.5
@export_custom(PROPERTY_HINT_NONE, "suffix:px") var inner_rim_distance := 50.0
@export_custom(PROPERTY_HINT_NONE, "suffix:px") var outer_rim_distance := 150.0
## Amount of polygon points in a full circle
@export var polygon_angle_resolution := 60.0
@export var area: Area2D

var flip_h := false:
	set(value):
		if flip_h != value:
			_flip_horizontally()
			flip_h = value

var _polygon: PackedVector2Array
var _bodies_in_cone: Array[Node2D] = []

func _ready():
	_polygon = generate_polygon()
	queue_redraw()


func generate_polygon() -> PackedVector2Array:
	var curve_resolution := TAU / polygon_angle_resolution
	var polygon := PackedVector2Array()
	var outer_rim := PackedVector2Array()
	
	var angle := starting_angle
	while angle <= starting_angle + angle_amplitude:
		var angle_v2 := Vector2.from_angle(angle)
		polygon.append(angle_v2 * inner_rim_distance)
		outer_rim.insert(0, angle_v2 * outer_rim_distance)
		angle += curve_resolution
	
	polygon.append_array(outer_rim)
	polygon.append(polygon[0]) # Close the polyline
	return polygon


func _draw():
	draw_colored_polygon(_polygon, color)
	draw_polyline(_polygon, border_color, border_width, true)


func _physics_process(_delta: float) -> void:
	var overlapping_bodies := area.get_overlapping_bodies()
	for body in overlapping_bodies:
		if is_in_cone(body.global_position):
			if body in _bodies_in_cone:
				continue # Already emitted character_entered for this one
			
			_bodies_in_cone.append(body)
			body_entered.emit(body)
	
	for body in _bodies_in_cone:
		if not is_in_cone(body.global_position):
			_bodies_in_cone.erase(body)
			body_exited.emit(body)

## Returns true if point (in global coordinates) is within the vision cone
func is_in_cone(point: Vector2) -> bool:
	var angle_to_point := (point - global_position).angle()
	angle_to_point = fposmod(angle_to_point, TAU) # Wrap angle around to make sure it is positive
	var angle_delta := angle_difference(starting_angle, angle_to_point)
	
	var angle_correct := angle_delta >= 0.0 and angle_delta <= angle_amplitude
	var distance_correct := (point - global_position).length_squared() <= outer_rim_distance * outer_rim_distance
	return angle_correct and distance_correct


func _flip_horizontally():
	starting_angle += PI
	starting_angle = fposmod(starting_angle, TAU) # Keep starting_angle in the range [0, TAU)
	_polygon = generate_polygon()
	queue_redraw()


func _on_flipped_horizontally(is_flipped: bool) -> void:
	flip_h = is_flipped
