class_name Enemy

extends Area2D

const ARROW_OFFSET := 5

@export var stats: Stats: set = setEnemyStats

@onready var sprite2D: Sprite2D = $Sprite2D
@onready var arrow: Sprite2D = $Arrow
@onready var statsUI: StatsUI = $StatsUI as StatsUI

func setEnemyStats(value: Stats) -> void:
	stats = value.create_instance()
	
	if not stats.stats_changed.is_connected(updateStats):
		stats.stats_changed.connect(updateStats)
	
	updateEnemy()

func updateStats() -> void:
	statsUI.updateStats(stats)

func updateEnemy() -> void:
	if not stats is Stats:
		return
	
	if not is_inside_tree():
		await ready
		
	sprite2D.texture = stats.art
	arrow.position = Vector2.RIGHT * (sprite2D.texture.get_size().x / 2 + ARROW_OFFSET)
	updateStats()

func takeDamage(damage: int) -> void:
	if stats.health <= 0:
		return
	
	stats.takeDamage(damage)
	
	if stats.health <= 0:
		queue_free()
