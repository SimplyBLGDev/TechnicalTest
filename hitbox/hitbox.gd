class_name Hitbox
extends Area2D

@export var damage := 2

func mirror_horizontally():
	for collision_shape: CollisionShape2D in Utils.find_node_descendants_of_type(self, CollisionShape2D):
		collision_shape.position.x = -collision_shape.position.x
