extends CanvasLayer

func _ready():
	GameManager.gained_coins.connect(update_coin_display)
	
func update_coin_display(gained_coins):
	$"Coin Icon/CoinDisplay".text = str(GameManager.coins)
