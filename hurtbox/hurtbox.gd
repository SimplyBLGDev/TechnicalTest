class_name Hurtbox
extends Area2D

@export var allow_self_damage := false

signal got_hit(damage: int, hit_position: Vector2)

func _ready():
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D):
	if not allow_self_damage and area.owner == owner:
		return
	if area is Hitbox:
		get_hit(area.damage, area.global_position - global_position)


func get_hit(damage: int, hit_position: Vector2):
	got_hit.emit(damage, hit_position)
