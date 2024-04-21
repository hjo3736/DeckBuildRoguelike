extends Node2D

@export var charStat: CharacterStats

@onready var battleUI: BattleUI = $BattleUI as BattleUI
@onready var playerHandler: PlayerHandler = $PlayerHandler as PlayerHandler
@onready var player: Player = $Player as Player


func _ready() -> void:
	var newStat: CharacterStats = charStat.create_instance()
	
	battleUI.charStat = newStat
	
	Events.player_turn_ended.connect(playerHandler.endTurn)
	Events.player_hand_discarded.connect(playerHandler.startTurn)
	
	startBattle(newStat)

func startBattle(value: CharacterStats) -> void:
	print("Battle Has Started")
	playerHandler.startBattle(value)
