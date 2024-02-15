extends Node2D

func _ready():
	$CoinSpin.play("Spin")

func _on_area_2d_area_entered(area):
	GameManager.gain_coins(1)
	queue_free()
