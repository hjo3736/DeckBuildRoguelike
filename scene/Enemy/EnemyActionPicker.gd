class_name EnemyActionPicker

extends Node

@export var enemy: Enemy: set = setEnemy
@export var target: Node2D: set = setTarget

@onready var totalWeight := 0.0

func _ready() -> void:
	target = get_tree().get_first_node_in_group("Player")
	setupChances()

func getAction() -> EnemyAction:
	var action := get_first_conditional_action()
	
	if action:
		return action
	
	return get_chane_based_action()

func get_first_conditional_action() -> EnemyAction:
	var action: EnemyAction
	
	for child in get_children():
		action = child as EnemyAction
		
		if not action or action.type != EnemyAction.Type.CONDITIONAL:
			continue
		
		if action.isPerformable():
			return action
	
	return null

func get_chane_based_action() -> EnemyAction:
	var action: EnemyAction
	var roll := randf_range(0.0, totalWeight)
	
	for child in get_children():
		action = child as EnemyAction
		
		if not action or action.type != EnemyAction.Type.CHANCE_BASED:
			continue
		
		if action.accumlatedWeight > roll:
			return action
	
	return null

func setupChances() -> void:
	var action: EnemyAction
	
	for child in get_children():
		action = child as EnemyAction
		
		if not action or action.type != EnemyAction.Type.CHANCE_BASED:
			continue
		
		totalWeight += action.chanceWeight
		action.accumlatedWeight = totalWeight

func setEnemy(value: Enemy) -> void:
	enemy = value
	
	for action in get_children():
		action.enemy = enemy

func setTarget(value: Node2D) -> void:
	target = value
	
	for action in get_children():
		action.target = target
