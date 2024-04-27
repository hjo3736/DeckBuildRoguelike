class_name Player

extends Node2D

const WHITE_SPRITE_MATERIAL := preload("res://Art/white_sprite_material.tres")

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
	
	sprite2D.material = WHITE_SPRITE_MATERIAL
	
	var tween := create_tween()
	tween.tween_callback(Shaker.shake.bind(self, 16, 0.15))
	tween.tween_callback(stats.takeDamage.bind(damage))
	tween.tween_interval(0.17)
	
	tween.finished.connect(
		func():
			sprite2D.material = null
			
			if stats.health <= 0:
				Events.player_died.emit()
				queue_free()
	)
