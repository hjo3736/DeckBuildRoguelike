class_name Card

extends Resource

enum Type {ATTACK, SKILL, POWER}
enum Target {SELF, SINGLE_ENEMY, ALL_ENEMIES, EVERYONE}

@export_group("Card Attributes")
@export var id: String
@export var type: Type
@export var target: Target
@export var cost: int

@export_group("Card Visuals")
@export var icon: Texture
@export_multiline var tooltipText: String

func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENEMY

func get_targets(targets: Array[Node]) -> Array[Node]:
	if not targets:
		return []
	
	var tree := targets[0].get_tree()
	
	match target:
		Target.SELF:
			return tree.get_nodes_in_group("player")
		Target.ALL_ENEMIES:
			return tree.get_nodes_in_group("Enemies")
		Target.EVERYONE:
			return tree.get_nodes_in_group("player") + tree.get_nodes_in_group("Enemies")
		_:
			return []

func play(targets: Array[Node], charStats: CharacterStats) -> void:
	Events.card_played.emit(self)
	charStats.mana -= cost
	
	if is_single_targeted():
		applyEffects(targets)
	else:
		applyEffects(get_targets(targets))

func applyEffects(targets: Array[Node]) -> void:
	pass
