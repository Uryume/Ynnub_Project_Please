extends Node2D


func _ready():
	$AnimatedSprite2D.play("default")
	
func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		AudioManager.health_sfx.play()
		area.get_parent().max_health +=1
		area.get_parent().health +=1
		queue_free()
