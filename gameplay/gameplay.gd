class_name Gameplay
extends Node2D

@export var default_mapping_context: GUIDEMappingContext

func _ready():
	GUIDE.enable_mapping_context(default_mapping_context)
