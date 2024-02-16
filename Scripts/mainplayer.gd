extends CharacterBody2D
class_name Player

@onready var animation = $Ynnub_anim
@onready var animating = $AnimationPlayer

@export var speed = 150.0
@export var jump_velocity = -200.0
@export var attacking = false


const dash_speed = 1000
const dash_duration = 0.2
@onready var dash = $Dash

var max_health = 10
var health = 0
var can_take_damage = true

var current_direction = "right"
var jumps_left = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	GameManager.player = self
	health = max_health


func _process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()

func _physics_process(delta):
	
	if is_on_floor():
		jumps_left = 2
	if Input.is_action_pressed("ui_left"):
		current_direction = "left"
		attacking = false
		animation.flip_h = true
	if Input.is_action_pressed("ui_right"):
		current_direction = "right"
		attacking = false
		animation.flip_h = false
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jumps_left > 0:
		velocity.y = jump_velocity
		jumps_left -= 1
		
	if Input.is_action_just_pressed("dash"):
		dash.start_dash(dash_duration)
	var dashingspeed = dash_speed if dash.is_dashing() else speed

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	update_animation()
	move_and_slide()
	
func _input(event):
	if event.is_action_pressed("ui_down") and is_on_floor():
		position.y +=30
	if event.is_action_pressed("dash"):
		if current_direction == "right":
			pass
		if current_direction =="left":
			pass

func update_animation():
	if !attacking:
		if !is_on_floor():
			animation.play("Jump_Right")
			$Ynnub_anim.position = Vector2()
		elif velocity.x != 0:
			$Ynnub_anim.position = Vector2()
			animation.play("Run_Right")
		else:
			$Ynnub_anim.position = Vector2()
			animation.play("Idle_Right")

func take_damage(damage_amount:int):
	
	if can_take_damage:
		iframes()
		health -= damage_amount
		
		if health <= 0:
			die()
			
func iframes():
	can_take_damage = false
	await get_tree().create_timer(0.2).timeout
	can_take_damage = true
	
func attack():
	
	var overlapping_objects =$AttackArea.get_overlapping_areas()
	
	for area in overlapping_objects:
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().die()
			
	
	if current_direction == "right":
		$Ynnub_anim.position = Vector2(7,0)
		$AttackArea.position = Vector2(6,0)
	if current_direction == "left":
		$Ynnub_anim.position = Vector2(-7,0)
		$AttackArea.position = Vector2(-14,0)
	
	attacking = true
	animation.play("Attack_Right")

func bounce():
	velocity.y = jump_velocity

func die():
	GameManager.respawn_player()
