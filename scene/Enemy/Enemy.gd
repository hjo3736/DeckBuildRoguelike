class_name Enemy

extends Area2D

const ARROW_OFFSET := 5
const WHITE_SPRITE_MATERIAL := preload("res://Art/white_sprite_material.tres")

@export var stats: EnemyStats: set = setEnemyStats

@onready var sprite2D: Sprite2D = $Sprite2D
@onready var arrow: Sprite2D = $Arrow
@onready var statsUI: StatsUI = $StatsUI as StatsUI
@onready var intentUI: IntentUI = $IntentUI as IntentUI
@onready var animationPlayer: AnimationPlayer = $Arrow/AnimationPlayer as AnimationPlayer

var enemyActionPicker: EnemyActionPicker
var currentAction: EnemyAction: set = setCurrentAction

func setCurrentAction(value: EnemyAction) -> void:
	currentAction = value
	if currentAction:
		intentUI.updateIntent(currentAction.intent)

func setEnemyStats(value: EnemyStats) -> void:
	stats = value.create_instance()
	
	if not stats.stats_changed.is_connected(updateStats):
		stats.stats_changed.connect(updateStats)
		stats.stats_changed.connect(updateAction)
	
	updateEnemy()

func setupAI() -> void:
	if enemyActionPicker:
		enemyActionPicker.queue_free()
	
	var newActionPicker: EnemyActionPicker = stats.ai.instantiate()
	add_child(newActionPicker)
	enemyActionPicker = newActionPicker
	enemyActionPicker.enemy = self

func updateStats() -> void:
	statsUI.updateStats(stats)

func updateAction() -> void:
	if not enemyActionPicker:
		return
	
	if not currentAction:
		currentAction = enemyActionPicker.getAction()
		return
	
	var newConditionalAction := enemyActionPicker.get_first_conditional_action()
	if newConditionalAction and currentAction != newConditionalAction:
			currentAction = newConditionalAction

func updateEnemy() -> void:
	if not stats is Stats:
		return
	
	if not is_inside_tree():
		await ready
		
	sprite2D.texture = stats.art
	arrow.position = Vector2.UP * (sprite2D.texture.get_size().y / 2 + intentUI.size.y + ARROW_OFFSET)
	setupAI()
	updateStats()

func doTurn() -> void:
	
	stats.block = 0
	
	if not currentAction:
		return
	
	currentAction.performAction()

func takeDamage(damage: int) -> void:
	if stats.health <= 0:
		return
	
	sprite2D.material = WHITE_SPRITE_MATERIAL
	
	var tween := create_tween()
	tween.tween_callback(Shaker.shake.bind(self, 16, 0.15))
	tween.tween_callback(stats.takeDamage.bind(damage))
	tween.tween_interval(0.17)
	
	tween.finished.connect(
		func():
			sprite2D.material = null
			
			if stats.health <= 0:
				queue_free()
	)


func _on_area_entered(area):
	arrow.show()
	animationPlayer.play("Pulse")

func _on_area_exited(area):
	arrow.hide()
	animationPlayer.stop()
