extends Area2D

var tile_map : TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("floor") and tile_map is TileMap:
		print("Floor")
		var tile_coords = Vector2i(tile_map.local_to_map($CollisionShape2D.global_position))
		tile_map.erase_cell(1, tile_coords)
		tile_map.erase_cell(0, tile_coords)
		tile_map.set_cell(0, tile_coords, 2, Vector2i(1,0))
		
	elif Input.is_action_just_pressed("wall") and tile_map is TileMap:
		print("wall")
		var tile_coords = Vector2i(tile_map.local_to_map($CollisionShape2D.global_position))
		tile_map.erase_cell(1, tile_coords)
		tile_map.erase_cell(0, tile_coords)
		tile_map.set_cell(1, tile_coords, 2, Vector2i(0,0))


func _on_body_entered(body):
	print("Collided")
	if body is TileMap:
		tile_map = body


func _on_body_exited(body):
	return
	print("hNad exited")
	if body is TileMap:
		tile_map = null
