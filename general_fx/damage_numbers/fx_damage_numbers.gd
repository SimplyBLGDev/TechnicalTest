class_name FX_DamageNumbers
extends Node2D

@export var label: Label
@export_custom(PROPERTY_HINT_NONE, "suffix:px/s") var initial_speed := 50.0
@export_custom(PROPERTY_HINT_NONE, "radians_as_degrees,suffix:º") var initial_angle_spread := PI * 0.5
@export_custom(PROPERTY_HINT_NONE, "suffix:px/s") var gravity := 200.0
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var duration := 0.5
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var fade_duration := 0.25

var velocity := Vector2.ZERO

static func instantiate(amount: int) -> FX_DamageNumbers:
	var instance: FX_DamageNumbers = load("uid://dfmvl01oltixv").instantiate()
	instance.label.text = str(amount)
	return instance


func _ready():
	var angle := randf_range(-initial_angle_spread * 0.5, initial_angle_spread * 0.5)
	velocity = (Vector2.UP * initial_speed).rotated(angle)
	
	var tween := create_tween()
	tween.tween_interval(duration)
	tween.tween_property(self, ^"modulate", Color.TRANSPARENT, fade_duration)
	tween.tween_callback(queue_free)
	tween.play()


func _process(delta: float) -> void:
	velocity.y += gravity * delta
	translate(velocity * delta)
