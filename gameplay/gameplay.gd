class_name Gameplay
extends Node2D

@export var default_mapping_contexts: Array[GUIDEMappingContext]
@export var restart: GUIDEAction

func _ready():
	for mapping_context in default_mapping_contexts:
		GUIDE.enable_mapping_context(mapping_context)
	
	restart.triggered.connect(_restart)


func _restart():
	get_tree().reload_current_scene()
