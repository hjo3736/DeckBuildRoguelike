class_name StatsUI

extends HBoxContainer

@onready var block: HBoxContainer = $Block
@onready var blockLabel: Label = %BlockLabel
@onready var health: HBoxContainer = $Health
@onready var healthLabel: Label = %HealthLabel

func updateStats(stats: Stats) -> void:
	print(stats.block)
	blockLabel.text = str(stats.block)
	healthLabel.text = str(stats.health)
	
	block.visible = stats.block > 0
	health.visible = stats.health > 0
