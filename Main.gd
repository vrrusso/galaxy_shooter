extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (PackedScene) var Asteroid = preload("res://Asteroid.tscn")
var number_asteroids = 7


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()
	set_asteroid_horde()
	
func _process(delta):
	if number_asteroids <= 0:
		number_asteroids = 7
		set_asteroid_horde()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_asteroid_horde():
	for _i in range(number_asteroids):
		spawn_asteroid()
		


func spawn_asteroid():
	$AsteroidsPath/AndroidsSpawnLocation.offset = randi()
	var ast = Asteroid.instance()
	add_child(ast)
	var direction = $AsteroidsPath/AndroidsSpawnLocation.rotation+PI/2
	ast.position=$AsteroidsPath/AndroidsSpawnLocation.position
	direction += rand_range(-PI/4,PI/4)
	ast.rotation = direction
	ast.linear_velocity = Vector2(50,0)
	ast.linear_velocity = ast.linear_velocity.rotated(direction)


	

func _on_PlayerShip_hit():
	game_over()
	


func game_over():
	$EnemySpawnTimer.stop()
	get_tree().call_group("asteroids","queue_free")



func new_game():
	$PlayerShip.start($InitialLocation.position)
	$EnemySpawnTimer.start()


func _on_EnemySpawnTimer_timeout():
	pass
	

func _on_hit_asteroid():
	number_asteroids-=1





