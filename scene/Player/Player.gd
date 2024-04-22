class_name Player

extends Node2D

@export var stats: CharacterStats: set = setCharacterStats

@onready var sprite2D: Sprite2D = $Sprite2D
@onready var statsUI: StatsUI = $StatsUI as StatsUI

func setCharacterStats(value: CharacterStats) -> void:
	stats = value
	
	if not stats.stats_changed.is_connected(updateStats):
		stats.stats_changed.connect(updateStats)
	
	updatePlayer()

func updatePlayer() -> void:
	if not stats is CharacterStats:
		return
	
	if not is_inside_tree():
		await ready
	
	sprite2D.texture = stats.art
	
	updateStats()
	
func updateStats() -> void:
	statsUI.updateStats(stats)

func takeDamage(damage: int) -> void:
	if stats.health <= 0:
		return
	
	stats.takeDamage(damage)
	
	if stats.health <= 0:
		Events.player_died.emit()
		queue_free()
