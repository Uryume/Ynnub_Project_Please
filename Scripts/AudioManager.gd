extends Node2D

func _ready():
	
	$AdventureMusic.play()
	
@onready var jump_sfx = $JumpSFX
@onready var jump_pad_sfx = $JumpPadSFX
@onready var coin_sfx = $CoinSFX
@onready var health_sfx = $HealthSFX
@onready var hurt_sfx = $HurtSFX
@onready var select_sfx = $SelectSFX
@onready var checkpoint_sfx = $CheckPointSFX
