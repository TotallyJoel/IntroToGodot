extends RigidBody3D

@export var initialForce = 100.00
@onready var forwardDirection = $Marker

var speed := 10.0

func _ready():
	apply_central_impulse(global_transform.basis.z * speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
 
const SPEED = 100.0 
var player_detected = false
var player = null

func _physics_process(_delta):
	if player_detected:
		var move_direction = (player.global_position - global_position).normalized();
		apply_central_force(move_direction * SPEED)


func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_detected = true


func _on_area_3d_body_exited(body):
	if body.is_in_group("player"):
		player = null
		player_detected = false
@export var health :=1 
