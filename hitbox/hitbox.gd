class_name Hitbox
extends Area2D

@export var allow_self_damage := false
@export var damage := 2

func _ready():
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D):
	if not allow_self_damage and area.owner == owner:
		return
	if area is Hurtbox:
		area.get_hit(damage)

## Mirror all children CollisionShape2Ds horizontally
func mirror_horizontally():
	for collision_shape: CollisionShape2D in Utils.find_node_descendants_of_type(self, CollisionShape2D):
		collision_shape.position.x = -collision_shape.position.x
