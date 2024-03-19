extends Node2D

func _ready():
	$AnimatedSprite2D.play("default")

func _on_area_2d_area_entered(area):
	GameManager.gain_keys(1)
	queue_free()
