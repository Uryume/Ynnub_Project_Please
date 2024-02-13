extends CharacterBody2D


var movement = Vector2()
var speed = 100
var jump_height = 2500
var fall_vel = 1
var current_direction = "Idle"

@onready var anim = $Ynnub_anim

@onready var stand_col = $Stand_col
@onready var jump_col = $Jump_col
@onready var has_a_landing =$Check_landing



func _ready():
	
	pass
	
	
func _physics_process(delta):
	
	current_gravity()
	Player_movement()
	animation_player()
	
	if has_a_landing.is_colliding():
		
		stand_col.disabled =  false
		jump_col.disabled = true
	
	movement = movement.normalized() * speed * delta
	move_and_slide()
	
	
	
func Player_movement():
	
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var JUMP = Input.is_action_just_pressed("ui_accept")
	
	var DOWN = Input.is_action_just_pressed("down")
	var UP = Input.is_action_just_pressed("ui_up")
	
	movement.x = -int(LEFT) + int(RIGHT)
	movement.y = -int(JUMP)

	if movement.x != 0:
		
		velocity.x = movement.x * speed
		
	else:
		
		velocity.x = 0
		
	if JUMP and is_on_floor():
		
		fall_vel -= jump_height


func animation_player():
	
	if movement.x == -1:
		
		stand_col.position = Vector2(4,1)
		current_direction = "Left"
		
	if movement.x == 1:
		
		stand_col.position = Vector2(-1,1)
		current_direction = "Right"
		
	if movement.x == -1 and !is_on_floor():
			jump_col.disabled = false
			stand_col.disabled = true
			anim.play("Jump_Left")
			
	if movement.x == 1 and !is_on_floor():
			jump_col.disabled = false
			stand_col.disabled = true
			anim.play_backwards("Jump_Right")
			
	check_direction()
			
func check_direction():
	if current_direction == "Left"  and is_on_floor():
		
		anim.play("Run_Left")
		
	if current_direction == "Right"  and is_on_floor():
		
		anim.play("Run_Right")
		
	if movement == Vector2.ZERO:
		
		if current_direction == "Left":
			
			anim.play("Idle_Left")
			
		if current_direction == "Right":
			
			anim.play("Idle_Right")
	
	
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
	
	pass
	
func swing_weapon():
	
	pass
