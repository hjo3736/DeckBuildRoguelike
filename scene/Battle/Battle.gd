extends Node2D

@export var charStat: CharacterStats

@onready var battleUI: BattleUI = $BattleUI as BattleUI
@onready var playerHandler: PlayerHandler = $PlayerHandler as PlayerHandler
@onready var enemyHandler: EnemyHandler = $EnemyHandler as EnemyHandler
@onready var player: Player = $Player as Player


func _ready() -> void:
	var newStat: CharacterStats = charStat.create_instance()
	
	battleUI.charStat = newStat
	
	player.stats = newStat
	
	enemyHandler.child_order_changed.connect(on_enemies_child_order_changed)
	Events.player_turn_ended.connect(playerHandler.endTurn)
	Events.player_hand_discarded.connect(enemyHandler.startTurn)
	Events.enemy_turn_ended.connect(on_enemy_turn_ended)
	Events.player_died.connect(on_player_died)
	
	startBattle(newStat)

func startBattle(value: CharacterStats) -> void:
	enemyHandler.resetEnemyAction()
	playerHandler.startBattle(value)

func on_enemies_child_order_changed() -> void:
	if enemyHandler.get_child_count() == 0:
		print("Victory!!!")

func on_player_died() -> void:
	print("Lose...")

func on_enemy_turn_ended() -> void:
	playerHandler.startTurn()
	enemyHandler.resetEnemyAction()
