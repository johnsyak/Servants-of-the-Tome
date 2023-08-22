extends CharacterBody2D


@export var movement_target: CharacterBody2D
@export var navigation_agent: NavigationAgent2D
@export var follow_timer: Timer
@export var attack_timer: Timer
@export var idle_timer: Timer
@export var rotation_speed = 50
@export var walk_speed:float = 10.0
@export var run_speed:float = 200.0

@onready var default_target = get_tree().get_nodes_in_group("tome")[0]
@onready var raycast = $RayCast2D

const PLATFORM_LAYER = 1 << (2 - 1)    # collision layer 2
const ITEM_BLOCK_LAYER = 1 << (1 - 1)  # collision layer 6
const NULL_TILE = Vector2i(-1, -1)  # TileMap atlas coordinates for invalid tile
const TILE_LAYER = 1
const PLATFORM_TILE = Vector2i(1, 0)  # TileMap atlas coordinates for platform tile

var layer_of_collision = null

var tile_map: TileMap

var colliders : Dictionary = {}

signal enemy_follow

func _physics_process(delta):
	var rotation_target = default_target
	if movement_target != null:
		rotation_target = movement_target
	var direction = (rotation_target.global_position - global_position)
	var angleTo = $Sprite2D.transform.x.angle_to(direction)
	$Sprite2D.rotate(sign(angleTo) * min(delta * rotation_speed, abs(angleTo)))
	
	var angle_ray = raycast.transform.x.angle_to(direction)
	raycast.rotate(sign(angleTo) * min(delta * rotation_speed, abs(angleTo)))
	var collision = move_and_slide()
	if collision:
		var collider = get_last_slide_collision().get_collider()
		if !collider is TileMap:
			return
		var tile_rid = get_last_slide_collision().get_collider_rid()
		var layer_of_collision = PhysicsServer2D.body_get_collision_layer(tile_rid)

		if layer_of_collision == ITEM_BLOCK_LAYER:
			var tile_world_coords = collider.get_coords_for_body_rid(tile_rid)
			var tile_source_id = collider.get_cell_source_id(TILE_LAYER, tile_world_coords, false)
			if tile_source_id == -1:
				layer_of_collision = null
				return
			
			collider.erase_cell(1, tile_world_coords)
			collider.erase_cell(0, tile_world_coords)
			collider.set_cell(0, tile_world_coords, 2, PLATFORM_TILE)
		
func _ready():
	follow_timer.stop()
	attack_timer.stop()
	idle_timer.start()

func _on_sonar_area_entered(area):
	movement_target = 	area.owner


func _on_wall_collision_body_entered(body):
	if body is TileMap:
		tile_map = body
		
#		var tile_coords = Vector2i(tile_map.local_to_map(marker.position))
#		print(tile_coords)
#		tile_map.erase_cell(1, tile_coords)
#		tile_map.erase_cell(0, tile_coords)
#		tile_map.set_cell(0, tile_coords, 2, Vector2i(0,0))
#		print("wall")
#		var tile_coords2 = Vector2i(tile_map.local_to_map($WallCollision/CollisionShape2D.global_position))
#		tile_map.erase_cell(1, tile_coords2)
#		tile_map.erase_cell(0, tile_coords2)
#		tile_map.set_cell(1, tile_coords2, 2, Vector2i(0,0))


func _on_wall_collision_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):	
		var tile_rid = get_last_slide_collision().get_collider_rid()
		var layer_of_collision = PhysicsServer2D.body_get_collision_layer(tile_rid)
		pass
#		if layer_of_collision == ITEM_BLOCK_LAYER:
#			var tile_world_coords = collider.get_coords_for_body_rid(tile_rid)
#			var tile_source_id = collider.get_cell_source_id(TILE_LAYER, tile_world_coords, false)
#			if tile_source_id == -1:
#				layer_of_collision = null
#				return
#
#			collider.erase_cell(1, tile_world_coords)
#			collider.erase_cell(0, tile_world_coords)
#			collider.set_cell(TILE_LAYER, tile_world_coords, tile_source_id, PLATFORM_TILE)
