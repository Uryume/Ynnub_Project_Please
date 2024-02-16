extends Control
class_name Healthbar

@onready var fill_max = $ColorRect.size.x
var fill_amount : float

func _ready():
	GameManager.healthbar = self

func update_healthbar(health,max_health):
	fill_amount = (float(health)/max_health) * fill_max
	$ColorRect.size.x = fill_amount
