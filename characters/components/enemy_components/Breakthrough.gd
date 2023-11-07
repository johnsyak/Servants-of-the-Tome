extends State
class_name breakthrough

signal breakthrough

@export var enemy: CharacterBody2D
@export var marker: Marker2D

const PLATFORM_TILE = Vector2i(1, 0)  # TileMap atlas coordinates for platform tile

func enter():
	enemy.velocity = Vector2(0,0)
	enemy.breakthrough_timer.start()
	
func exit():
	enemy.breakthrough_timer.stop()

func update(_delta: float):
	pass

func _on_breakthrough_timer_timeout():
	for collider in enemy.colliders:
		collider.erase_cell(1, enemy.colliders[collider])
		collider.erase_cell(0, enemy.colliders[collider])
		collider.set_cell(0, enemy.colliders[collider], 2, enemy.PLATFORM_TILE)
		Transitioned.emit(self, "EnemyFollow")
