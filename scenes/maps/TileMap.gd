extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Player").break_block.connect(_on_break_block)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_break_block(coords):
	print("BLOCK BROKEN! " + str(coords))
	var tile: Vector2 = local_to_map(coords[0])
	set_cell(1, tile, -1)




	

