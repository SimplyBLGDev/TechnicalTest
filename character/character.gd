class_name Player
extends CharacterBody2D

@export var parameters: Character_Parameters

@export_group("Components")
@export var controller: Character_Controller
@export var state_machine: StateMachine
@export var sprite: Character_Sprite
@export var animation_player: AnimationPlayer
@export var health_component: HealthComponent

var facing_left:
	set(value):
		sprite.flip_h = value
	get:
		return sprite.flip_h

func spawn_hitbox(hitbox_scene: PackedScene, duration: float):
	var instance: Hitbox = hitbox_scene.instantiate()
	add_child(instance)
	instance.owner = self
	if facing_left:
		instance.mirror_horizontally()
	
	await get_tree().create_timer(duration).timeout
	instance.queue_free()


func _on_hurtbox_got_hit(damage: int) -> void:
	health_component.receive_damage(damage)
	var hurt_state: Character_State_Hurt = state_machine.get_state(Character_State.HURT)
	state_machine.change_state(hurt_state)
