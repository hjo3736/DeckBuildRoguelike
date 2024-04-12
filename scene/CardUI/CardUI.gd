class_name CardUI
extends Control

signal reparent_request(which_card_ui : CardUI)

@onready var color: ColorRect = $Color
@onready var state: Label = $State
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var cardStateMachine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var targets: Array[Node] = []

func _ready() -> void:
	cardStateMachine.init(self)

func _input(event: InputEvent) -> void:
	cardStateMachine.on_input(event)

func _on_gui_input(event: InputEvent) -> void:
	cardStateMachine.on_gui_input(event)

func _on_mouse_entered() -> void:
	cardStateMachine.on_mouse_entered()

func _on_mouse_exited() -> void:
	cardStateMachine.on_mouse_exited()

func _on_drop_point_detector_area_entered(area):
	if not targets.has(area):
		targets.append(area)
		
func _on_drop_point_detector_area_exited(area):
	targets.erase(area)
