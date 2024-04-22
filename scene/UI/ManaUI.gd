class_name ManaUI

extends Panel

@export var charStat: CharacterStats: set = _set_character_stat

@onready var manaLabel: Label = $ManaLabel

func _set_character_stat(value: CharacterStats) -> void:
	charStat = value
	
	if not charStat.stats_changed.is_connected(on_stats_changed):
		charStat.stats_changed.connect(on_stats_changed)
	
	if not is_node_ready():
		await ready
	
	on_stats_changed()
	
func on_stats_changed() -> void:
	manaLabel.text = "%s/%s" % [charStat.mana, charStat.maxMana]
