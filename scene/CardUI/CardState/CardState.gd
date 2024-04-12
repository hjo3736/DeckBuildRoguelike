class_name CardState
extends Node

enum State {BASE, CLICK, DRAGGING, AIMING, RELEASED}

#EventHandler?
signal transition_requested(from: CardState, to: State)

@export var state: State

var cardUI: CardUI

func enter() -> void:
	pass
func exit() -> void:
	pass
func on_input(_event : InputEvent) -> void:
	pass
func on_gui_input(_event :InputEvent) -> void:
	pass
func on_mouse_entered() -> void:
	pass
func on_mouse_exited() -> void:
	pass
