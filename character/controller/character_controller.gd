@abstract
class_name Character_Controller
extends Node

@warning_ignore("unused_signal")
signal attacked # Signal is emitted by concrete implementations of the controller

var move_direction := Vector2.ZERO
