class_name Hurtbox
extends Area2D

signal got_hit(damage: int)

func get_hit(damage: int):
	got_hit.emit(damage)
