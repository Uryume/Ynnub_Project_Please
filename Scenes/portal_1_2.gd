extends Area2D

var entered = false

func _input(event):
	if event.is_action_pressed("interact"):
		get_tree().change_scene_to_file("res://Scenes/World1.tscn")
			

func _on_body_entered(body:PhysicsBody2D):
	entered = true

func _on_body_exited(body):
	entered = false
