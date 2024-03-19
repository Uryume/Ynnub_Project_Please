extends CanvasLayer

func _ready():
	GameManager.pause_menu = $"Pause Menu"
	GameManager.gained_coins.connect(update_coin_display)
	GameManager.gained_keys.connect(update_key_display)
	
func update_coin_display(gained_coins):
	$"Coin Icon/CoinDisplay".text = str(GameManager.coins)
	
func update_key_display(gained_keys):
	$"Key Icon/KeyDisplay".text = str(GameManager.keys)

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		GameManager.pause_play()

func _on_resume_pressed():
	GameManager.resume()

func _on_restart_pressed():
	GameManager.restart()

func _on_quit_pressed():
	GameManager.quit()
