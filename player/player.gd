class_name Player
extends CharacterBody2D

@export var parameters: Player_Parameters

@export_group("Components")
@export var controller: Player_Controller
@export var state_machine: StateMachine
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer

var facing_left:
	set(value):
		sprite.flip_h = value
	get:
		return sprite.flip_h

func spawn_hitbox(hitbox_scene: PackedScene, duration: float):
	var instance: Hitbox = hitbox_scene.instantiate()
	add_child(instance)
	if facing_left:
		instance.mirror_horizontally()
	
	await get_tree().create_timer(duration).timeout
	instance.queue_free()
