extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 400 #the ship speed in pixels/s

var enlapsed_time_since_shoot = 0

export (PackedScene) var Projectile = preload("res://Projectile.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	enlapsed_time_since_shoot+=delta
	var velocity = Vector2()
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity*delta
	
	
	if Input.is_action_just_pressed("move_up"):
		$ShipAnimation.animation = "acceleration_slow"
	elif velocity.y < 0:
		$ShipAnimation.animation = "acceleration_fast"
	else:
		$ShipAnimation.animation = "stable"
	
	if Input.is_action_just_pressed("shoot") and enlapsed_time_since_shoot>0.5:
		shoot()
		enlapsed_time_since_shoot = 0
	
	


#this only runs if the main is executated - remove the global referencer if you want to execute locally
func shoot():
	var p = Projectile.instance()
	owner.add_child(p)
	p.transform = $ProjectileOrigin.global_transform
	p.scale = Vector2(0.5,0.5)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
