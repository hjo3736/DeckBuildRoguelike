extends CanvasLayer

@onready var colorRect: ColorRect = $ColorRect
@onready var timer: Timer = $Timer

func _ready():
	Events.player_hit.connect(on_player_hit)
	timer.timeout.connect(on_timer_timeout)

func on_player_hit() -> void:
	colorRect.color.a = 0.2
	timer.start()

func on_timer_timeout() -> void:
	colorRect.color.a = 0.0
