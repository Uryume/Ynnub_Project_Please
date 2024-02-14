extends CharacterBody2D

@onready var loading_bullets = preload("res://Scenes/bullets.tscn")
var movement = Vector2()
var bullet_direction = Vector2()
var speed = 100
var jump_height = 2500
var fall_vel = 1
var current_direction = "Idle"

@onready var bullet_marker =$Bullet_exit_pos

@onready var anim = $Ynnub_anim

@onready var stand_col = $Stand_col
@onready var jump_col = $Jump_col
@onready var has_a_landing =$Check_landing
@onready var has_a_landing2 =$Check_landing2


func _ready():
	
	pass
	
	
func _physics_process(delta):
	update_direction()
	current_gravity()
	Player_movement()
	animation_player()
	check_bullet_direction()
	
	if has_a_landing.is_colliding() or has_a_landing2.is_colliding:
		
		stand_col.disabled =  false
		jump_col.disabled = true
		
	
	movement = movement.normalized() * speed * delta
	move_and_slide()
	
	
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
	
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var JUMP = Input.is_action_just_pressed("ui_accept")
	
	var UP = Input.is_action_just_pressed("ui_up")
	
	movement.x = -int(LEFT) + int(RIGHT)
	movement.y = -int(JUMP)

	if movement.x != 0:
		
		velocity.x = movement.x * speed
		
	else:
		
		velocity.x = 0
		
	if JUMP and is_on_floor():
		
		velocity.y -= jump_height
		
	if Input.is_action_just_pressed("fire_weapon") :##and current_direction !="Idle":
		
		fire_weapon()
		
func check_bullet_direction():
	if current_direction == "Left":
		bullet_marker.position == Vector2(-1,0)
		bullet_direction.x = -1

	if current_direction == "Right":
		bullet_marker.position == Vector2(-1,0)
		bullet_direction.x = 1

func animation_player():
	print("Current Direction: ", current_direction)
	if !is_on_floor():
		if current_direction == "Left":
			anim.play("Jump_Left")
		else:
			anim.play("Jump_Right")
	elif movement.x != 0:
		if current_direction == "Left":
			anim.play("Run_Left")
		else:
			anim.play("Run_Right")
	else:
		if current_direction == "Left":
			anim.play("Idle_Left")
		else:
			anim.play("Idle_Right")
			
	check_direction()
			
func check_direction():
	if current_direction == "Left"  and is_on_floor():
		
		anim.play("Run_Left")
		
	if current_direction == "Right"  and is_on_floor():
		
		anim.play("Run_Right")
		
	if movement == Vector2.ZERO:
		
		if current_direction == "Left":
			
			anim.play("Idle_Left")
			
			if !is_on_floor():
				anim.play("Jump_Left")
				
		if current_direction == "Right":
			
			anim.play("Idle_Right")
			
			if !is_on_floor():
				anim.play("Jump_Right")
				
	
func current_gravity():
	
	var new_gravity = gravity_force.new()
	
	velocity.y = fall_vel
	
	if !is_on_floor():
		
		fall_vel += new_gravity.gravity_str
		
	if is_on_floor():
		
		fall_vel = 5
		
	if fall_vel >= new_gravity.terminal_vel:
		
		fall_vel = new_gravity.terminal_vel
		
func fire_weapon():
	
	var get_bullets = loading_bullets.instantiate()
	
	if current_direction =="Left":
		
		get_bullets.check_direction(bullet_direction.x)
		
	if current_direction =="Right":
		
		get_bullets.check_direction(bullet_direction.x)
		
	get_parent().add_child(get_bullets)
	
	get_bullets.position = bullet_marker.global_position
	
func swing_weapon():
	
	pass
