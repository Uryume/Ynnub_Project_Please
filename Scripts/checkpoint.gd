extends Node2D
class_name Checkpoint

@export var spawnpoint = false

var activated = false

func _ready():
	if spawnpoint:
		activate()

func activate():
	GameManager.current_checkpoint = self
	activated = true
	$Sprite2D.play("Activated")

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player and !activated:
		AudioManager.checkpoint_sfx.play()
		activate()
