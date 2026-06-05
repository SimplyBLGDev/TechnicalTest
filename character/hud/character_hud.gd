class_name Player_HUD
extends Control

@export var health_component: HealthComponent
@export var health_bar: ProgressBar

func _ready():
	health_component.health_changed.connect(_update_remaining_health)
	health_bar.max_value = health_component.max_health
	_update_remaining_health()


func _update_remaining_health():
	health_bar.value = health_component.health
