class_name DustEmitter
extends Node2D

@export var period := 0.5

var _is_emitting := false
var t := 0.0

func start_emitting():
	t = 0.0
	_is_emitting = true


func stop_emitting():
	_is_emitting = false


func _process(delta: float) -> void:
	if not _is_emitting:
		return
	
	t += delta
	if t >= period:
		t -= period
		_emit_particle()


func _emit_particle():
	var dust := FX_Dust.instantiate()
	get_parent().add_sibling(dust)
	dust.global_position = global_position
