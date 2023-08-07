extends Area2D

@export var speed := 400

var attack_damage := 10.0
var knockback_force := 100
var stun_time := 1.5
var target
var velocity
var screen_size

func start(pos):
	target = get_viewport().get_mouse_position()
	screen_size = get_viewport_rect().size
	position = pos
	
func _physics_process(delta):
	position += transform.x * speed * delta
	
func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area is HitBoxComponent:
		var hitbox : HitBoxComponent = area
		var attack = Attack.new()
		
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position
		#attack.stun_time = stun_time
		hitbox.damage(attack)
		queue_free()
		
func _on_body_entered(body):
	if body is TileMap:
		queue_free()



