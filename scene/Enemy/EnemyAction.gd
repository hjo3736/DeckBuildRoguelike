class_name EnemyAction

extends Node

enum Type {CONDITIONAL, CHANCE_BASED}

@export var type: Type
@export_range(0.0, 10.0) var chanceWeight := 0.0

@onready var accumlatedWeight := 0.0

var enemy: Enemy
var target: Node2D

func isPerformable() -> bool:
	return false

func performAction() -> void:
	pass	
