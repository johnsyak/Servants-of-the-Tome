class_name Projectile
extends Node2D

export var speed := 1000.0
export var lifetime := 3.0

var direction := Vector2.ZERO

onready var timer := $Timer
onready var sprite := $Sprite2D
onready var 
