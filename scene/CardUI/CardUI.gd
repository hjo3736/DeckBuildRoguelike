class_name CardUI

extends Control

signal reparent_request(which_card_ui : CardUI)

const AttackCard := preload("res://Art/ForTest/card_frame01.png")
const SkillCard := preload("res://Art/ForTest/card_frame07.png")
const PowerCard := preload("res://Art/ForTest/card_frame08.png")

const borderIdle := preload("res://Theme/BorderIdle.tres")
const borderGlow := preload("res://Theme/BorderGlow.tres")

@export var card: Card: set = _set_card
@export var charStat: CharacterStats : set = _set_character_stat

@onready var border: Panel = $Border
@onready var baseImage: TextureRect = $Border/BaseImage
@onready var cost: Label = $Cost
@onready var icon: TextureRect = $Icon

@onready var dropPointDetector: Area2D = $DropPointDetector
@onready var cardStateMachine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var targets: Array[Node] = []
@onready var originalIndex := self.get_index()

var parent: Control
var tween: Tween
var playable := true : set = _set_playable
var disabled := false

func _ready() -> void:
	Events.card_aim_started.connect(_on_card_drag_or_aiming_started)
	Events.card_aim_ended.connect(_on_card_drag_or_aiming_ended)
	Events.card_drag_started.connect(_on_card_drag_or_aiming_started)
	Events.card_drag_ended.connect(_on_card_drag_or_aiming_ended)
	cardStateMachine.init(self)

func _input(event: InputEvent) -> void:
	cardStateMachine.on_input(event)

func play() -> void:
	if not card:
		return
		
	card.play(targets, charStat)
	queue_free()

func animate_to_position(newPos: Vector2, duration: float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", newPos, duration)

func _on_gui_input(event: InputEvent) -> void:
	cardStateMachine.on_gui_input(event)

func _on_mouse_entered() -> void:
	cardStateMachine.on_mouse_entered()

func _on_mouse_exited() -> void:
	cardStateMachine.on_mouse_exited()

func _set_card(value: Card) -> void:
	if not is_node_ready():
		await ready
	
	card = value
	
	if(card.type == Card.Type.ATTACK):
		baseImage.texture = AttackCard
	elif(card.type == Card.Type.SKILL):
		baseImage.texture = SkillCard
	else:
		baseImage.texture = PowerCard
	
	cost.text = str(card.cost)
	icon.texture = card.icon

func _set_playable(value: bool) -> void:
	playable = value
	if not playable:
		border.set("theme_override_styles/panel", borderIdle)
		cost.add_theme_color_override("font_color", Color.RED)
		icon.modulate = Color(1, 1, 1, 0.5)
	else:
		border.set("theme_override_styles/panel", borderGlow)
		cost.remove_theme_color_override("font_color")
		icon.modulate = Color(1, 1, 1, 1)

func _set_character_stat(value: CharacterStats) -> void:
	charStat = value
	charStat.stats_changed.connect(_on_char_stats_changed)

func _on_drop_point_detector_area_entered(area):
	if not targets.has(area):
		targets.append(area)
		
func _on_drop_point_detector_area_exited(area):
	targets.erase(area)

func _on_card_drag_or_aiming_started(userCard: CardUI) -> void:
	if userCard == self:
		return
	
	disabled = true

func _on_card_drag_or_aiming_ended(_card: CardUI) -> void:
	disabled = false
	self.playable = charStat.canPlayCard(card)

func _on_char_stats_changed() -> void:
	self.playable = charStat.canPlayCard(card)
