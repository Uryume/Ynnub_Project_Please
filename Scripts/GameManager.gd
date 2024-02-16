extends Node

signal gained_coins(int)
var coins : int
var current_checkpoint : Checkpoint
var healthbar:Healthbar
var player : Player
var paused = false
var pause_menu

func _process(delta):
	healthbar.update_healthbar(player.health,player.max_health)

func respawn_player():
	player.health = player.max_health
	if current_checkpoint != null:
		player.global_position = current_checkpoint.global_position

func gain_coins(coins_gained:int):
	coins += coins_gained
	emit_signal("gained_coins", coins_gained)
	
func pause_play():
	paused = !paused
	pause_menu.visible = paused

func resume():
	pause_play()

func restart():
	coins = 0
	get_tree().reload_current_scene()

func quit():
	get_tree().quit()
