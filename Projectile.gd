extends Area2D

var speed = 900

signal hit_asteroid

func _ready():
	pass

func _physics_process(delta):
	position -= transform.y * speed * delta



func _on_Projectile_body_entered(body):
	if body.is_in_group("asteroids"):
		body.queue_free()
	queue_free()
	emit_signal("hit_asteroid")
