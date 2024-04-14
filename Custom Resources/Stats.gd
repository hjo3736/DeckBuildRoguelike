class_name Stats

extends Resource

signal stats_changed

@export var maxHealth := 1
@export var art: Texture
@export var startBlock := 0

var health: int : set = setHealth
var block: int : set = setBlock

func setHealth(value: int) -> void:
	health = clampi(value, 0, maxHealth)
	stats_changed.emit()

func setBlock(value: int) -> void:
	block = clampi(value, 0, 999)
	stats_changed.emit()

func takeDamage(damage: int) -> void:
	if damage <= 0:
		return
	
	var initialDamage = damage
	damage = clampi(damage - block, 0, damage)
	self.block = clampi(block - initialDamage, 0, block)
	self.health -= damage

func heal(amount: int) -> void:
	self.health += amount

func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.health = maxHealth
	instance.block = startBlock
	return instance
