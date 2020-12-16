extends KinematicBody2D
onready var player1pos = $Player1Pos
onready var player2pos = $Player2Pos
const UP = Vector2(0,-1)
var speed = Vector2()
var xDir = 0
export var maxspeed = 450
export var aceleration = 16 
export var friction = 0.4

#jumping
var jump = 0
export var doublejumps = 1
var djump = 0
export var jumpforce = 450
export var gravity = 16

remote func _set_position(pos):
	global_transform.origin = pos

func _physics_process(delta):
	#player movement keys
	var lKey = Input.is_action_pressed("ui_left")
	var rKey = Input.is_action_pressed("ui_right")
	var jKey = Input.is_action_just_pressed("ui_up")
	
	var previousPos = position
	
	#Gets the player x direction
	xDir = int(rKey) - int(lKey)
	speed.x += aceleration*xDir
	
	#Sets max movement speed
	speed.x = clamp(speed.x, -maxspeed, maxspeed)
	
	#adds gravity
	speed.y += gravity
	
	#floor collision
	if is_on_floor():
		jump = 1
		if not xDir:
			speed.x = lerp(speed.x,0,friction)
		djump = doublejumps
	else:
		jump = 0
	
	#jumping
	if jump + djump > 0 and jKey:
		speed.y = -jumpforce
		if not jump:
			djump -= 1
	if previousPos == position:
		if is_network_master():
			speed = move_and_slide(speed, UP)	
			rpc_unreliable("_set_position", global_transform.origin)
