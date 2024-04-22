class_name EnemyHandler

extends Node2D

func _ready() -> void:
	Events.enemy_action_completed.connect(on_enemy_action_completed)

func resetEnemyAction()-> void:
	var enemy: Enemy
	for child in get_children():
		enemy = child as Enemy
		enemy.currentAction = null
		enemy.updateAction()

func startTurn() -> void:
	if get_child_count() == 0:
		return
	
	var firstEnemy: Enemy = get_child(0) as Enemy
	firstEnemy.doTurn()

func on_enemy_action_completed(enemy: Enemy) -> void:
	if enemy.get_index() == get_child_count() - 1:
		Events.enemy_turn_ended.emit()
		return
	
	var nextEnemy: Enemy = get_child(enemy.get_index() + 1) as Enemy
	nextEnemy.doTurn()
	
