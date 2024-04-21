class_name PlayerHandler

extends Node

const HAND_DRAW_INTERVAL := 0.25
const HAND_DISCARD_INTERVAL := 0.25

@export var hand: Hand

var character: CharacterStats

func _ready() -> void:
	Events.card_played.connect(_on_card_played)

func startBattle(charStat: CharacterStats) -> void:
	character = charStat
	character.drawPile = character.deck.duplicate(true)
	character.drawPile.shuffle()
	character.discard = CardPile.new()
	startTurn()

func startTurn() -> void:
	character.block = 0
	character.resetMana()
	drawCards(character.cardPerTurn)

func endTurn() -> void:
	hand.disableHand()
	discardCards()

func drawCard() -> void:
	reshuffle_deck_from_discard()
	hand.addCard(character.drawPile.drawCard())
	reshuffle_deck_from_discard()

func drawCards(amount: int) -> void:
	var tween := create_tween()
	for i in range(amount):
		tween.tween_callback(drawCard)
		tween.tween_interval(HAND_DRAW_INTERVAL)
	
	tween.finished.connect(
		func(): Events.player_hand_drawn.emit()
	)

func discardCards() -> void:
	var tween := create_tween()
	
	for cardUI in hand.get_children():
		tween.tween_callback(character.discard.addCard.bind(cardUI.card))
		tween.tween_callback(hand.discardCard.bind(cardUI))
		tween.tween_interval(HAND_DISCARD_INTERVAL)
	
	tween.finished.connect(
		func():
			Events.player_hand_discarded.emit()
	)

func reshuffle_deck_from_discard() -> void:
	if not character.drawPile.empty():
		return
	
	while not character.discard.empty():
		character.drawPile.addCard(character.discard.drawCard())
	
	character.drawPile.shuffle()

func _on_card_played(card: Card) -> void:
	character.discard.addCard(card)
