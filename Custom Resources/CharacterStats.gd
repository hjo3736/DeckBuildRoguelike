class_name CharacterStats

extends Stats

@export var startingDeck: CardPile
@export var cardPerTurn: int
@export var maxMana: int

var mana: int: set = setMana
var deck: CardPile
var discard: CardPile
var drawPile: CardPile

func setMana(value: int) -> void:
	mana = value
	stats_changed.emit()

func resetMana() -> void:
	self.mana = maxMana

func takeDamage(damage: int) -> void:
	var initialHealth := health
	super.takeDamage(damage)
	
	if initialHealth > health:
		Events.player_hit.emit()

func canPlayCard(card: Card) -> bool:
	return mana >= card.cost

func create_instance() -> Resource:
	var instance: CharacterStats = self.duplicate()
	instance.health = maxHealth
	instance.block = 0
	instance.resetMana()
	instance.deck = instance.startingDeck.duplicate()
	instance.drawPile = CardPile.new()
	instance.discard = CardPile.new()
	
	return instance
