extends Area2D


var bullet_speed = 10
var bullet_movement = Vector2()
var bullet_direction = 1
var bullet_life = 0


func _ready():
	
	pass

func check_direction(dir):
	
	bullet_direction = dir

func _physics_process(delta):
	
	bullet_life += 1
	
	bullet_movement.x = bullet_speed * delta * bullet_direction
	
	translate(bullet_movement.normalized() * bullet_speed)
	
	
	if bullet_life >= 100:
		
		queue_free()


func _on_body_entered(body):
	
	if !body.name =="Player":
		queue_free()
