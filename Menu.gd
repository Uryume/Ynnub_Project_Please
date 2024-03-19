extends Control


func _ready():
	$CanvasLayer/AnimationPlayer.play("Fade In")

func _process(delta):
	pass


func _on_start_button_pressed():
	AudioManager.select_sfx.play()
	get_tree().change_scene_to_file("res://Scenes/hub.tscn")


func _on_options_button_pressed():
	pass


func _on_quit_button_pressed():
	get_tree().quit()
