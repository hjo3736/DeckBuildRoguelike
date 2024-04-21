class_name BattleUI

extends CanvasLayer

@export var charStat: CharacterStats: set = setCharacterStat

@onready var hand: Hand = $Hand as Hand
@onready var manaUI: ManaUI = $ManaUI as ManaUI
@onready var endTurnButton: TextureButton = $EndTurnButton

func _ready() -> void:
	Events.player_hand_drawn.connect(_on_player_hand_drawn)
	endTurnButton.pressed.connect(_on_end_turn_button_pressed)

func setCharacterStat(value: CharacterStats) -> void:
	charStat = value
	manaUI.charStat = charStat
	hand.charStat = charStat

func _on_player_hand_drawn() -> void:
	endTurnButton.disabled = false

func _on_end_turn_button_pressed() -> void:
	endTurnButton.disabled = true
	Events.player_turn_ended.emit()
