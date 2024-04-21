class_name Tooltip

extends PanelContainer

@export var fadeSeconds := 0.2

@onready var tooltipLabel: RichTextLabel = %TooltipLabel

var tween: Tween
var isVisible := false

func _ready() -> void:
	Events.card_tooltip_requested.connect(showTooltip)
	Events.tooltip_hide_requested.connect(hideTooltip)
	modulate = Color.TRANSPARENT
	hide()

func showTooltip(text: String) -> void:
	isVisible = true
	if tween:
		tween.kill()
	
	tooltipLabel.text = text
	
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(show)
	tween.tween_property(self, "modulate", Color.WHITE, fadeSeconds)

func hideTooltip() -> void:
	isVisible = false
	if tween:
		tween.kill()
	
	get_tree().create_timer(fadeSeconds, false).timeout.connect(hideAnimation)

func hideAnimation() -> void:
	if not isVisible:
		tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "modulate", Color.TRANSPARENT, fadeSeconds)
		tween.tween_callback(hide)
