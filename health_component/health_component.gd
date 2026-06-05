class_name HealthComponent
extends Node

signal health_changed
signal health_depleted

@export var max_health := 10
var health := 0

func _ready():
	health = max_health
	health_changed.emit()


func receive_damage(amount: int):
	health -= amount
	health_changed.emit()
	
	if health <= 0:
		health_depleted.emit()
		health = 0
