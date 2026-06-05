extends BTAction

@export var patrol_points_group :=  &"PatrolPoint"

func _enter() -> void:
	var patrol_points := PackedVector2Array()
	for point in Utils.find_node_descendants_in_group(agent.get_tree().root, patrol_points_group):
		patrol_points.append(point.global_position)
	
	var chosen_point := patrol_points[randi() % len(patrol_points)]
	blackboard.set_var(&"patrol_next_position", chosen_point)


func _tick(_delta: float) -> Status:
	return Status.SUCCESS
