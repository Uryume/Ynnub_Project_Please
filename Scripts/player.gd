extends CharacterBody2D

@onready var loading_bullets = preload("res://Scenes/bullets.tscn")
var movement = Vector2.ZERO
var speed = 100
var jumps_left = 2
var jump_height = 2000
var fall_vel = 1

var current_direction = "Idle"
var bullet_direction = Vector2()

@onready var bullet_marker =$Bullet_exit_pos

@onready var anim = $Ynnub_anim
@onready var coyote_timer = $CoyoteTimer
@onready var stand_col = $Stand_col
@onready var jump_col = $Jump_col
@onready var has_a_landing =$Check_landing
@onready var has_a_landing2 =$Check_landing2

@onready var healthbar = $Healthbar

@export var attacking = false

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		transform
		attack()
	
func _physics_process(delta):
	update_direction()
	Player_movement()
	check_bullet_direction()
	
	if has_a_landing.is_colliding() or has_a_landing2.is_colliding:
		
		stand_col.disabled =  false
		jump_col.disabled = true
		
		
	movement = movement.normalized() * speed * delta
	var was_on_floor = is_on_floor()
	
	move_and_slide()
	if !is_on_floor() and was_on_floor:
		pass
	
func update_direction():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")

	if LEFT and !RIGHT:
		current_direction = "Left"
	elif RIGHT and !LEFT:
		current_direction = "Right"
	else:
		current_direction = "Idle"

func Player_movement():
	
	if is_on_floor():
		jumps_left = 2
		
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var JUMP = Input.is_action_just_pressed("ui_accept")
	
	movement.x = -int(LEFT) + int(RIGHT)
	movement.y = -int(JUMP) *  get_physics_process_delta_time()

	if movement.x != 0:
		
		velocity.x = movement.x * speed 

	else:
		velocity.x = 0
		
	if JUMP and jumps_left > 0:
		
		velocity.y -= jump_height
		jumps_left -= 1
		
	if Input.is_action_just_pressed("fire_weapon") :##and current_direction !="Idle":
		
		fire_weapon()
		
func check_bullet_direction():
	if current_direction == "Left":
		bullet_marker.position = Vector2(45,35)
		bullet_direction.x = -1

	if current_direction == "Right":
		bullet_marker.position = Vector2(55,35)
		bullet_direction.x = 1
		
func attack():
	var overlapping_objects = $AttackArea.get_overlapping_areas()
	
	for area in overlapping_objects:
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().die()
		
	attacking = true
	anim.play("Attack_Right")

	
func fire_weapon():
	var get_bullets = loading_bullets.instantiate()
	if current_direction =="Left":
		get_bullets.check_direction(bullet_direction.x)
	if current_direction =="Right":
		get_bullets.check_direction(bullet_direction.x)
	get_parent().add_child(get_bullets)

	get_bullets.position = bullet_marker.global_position
	

