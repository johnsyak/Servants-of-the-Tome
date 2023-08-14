extends TileMap

@onready var enemy = $"../DefaultEnemy".get_node("StateMachine").get_node("Breakthrough")

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy.breakthrough.connect(_on_breakthrough)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_breakthrough(coords):
#	print("BLOCK BROKEN! " + str(coords))
	#set_cell(1, local_to_map(coords), -1)
	erase_cell(1, local_to_map(coords))




	

