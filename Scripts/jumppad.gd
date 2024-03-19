extends Node2D

@export var force = -425.0

var bounce = false

func _ready():
	if bounce == false:
		$AnimatedSprite2D.play("idle")

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		bounce = true
		if bounce == true:
			AudioManager.jump_pad_sfx.play()
			$AnimatedSprite2D.play("default")
			area.get_parent().velocity.y = force
			bounce = false
			
		
