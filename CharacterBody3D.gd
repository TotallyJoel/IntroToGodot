extends CharacterBody3D
@export var gravity := 50.0
@export var speed := 8.0
@export var jump_force :=20.0 

@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var mesh: MeshInstance3D = $MeshInstance3D

var angular_acceleration := 7
const SPEED = 5.0
const JUMP_VELOCITY = 4.5





func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(direction.x,direction.z), delta * angular_acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

var object_class = preload("res://node_3d.tscn")

@onready var shoot_position = $"../../MeshInstance3D/Marker3D"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body. 


# Called every frame. 'delta" is the elapsed time since the previous frame.
func _process(_delta):
	var root = get_tree().get_root().get_node("World")
	if Input.is_action_just_pressed("shoot"):
		print("shoot")
		var object_instance = object_class.instantiate()
		object_instance.position = shoot_position.global_position
		object_instance.rotation.y = $"../..?MeshInstance3D" .rotation.y
		root. add_child(object_instance)
		
extends RigidBody3D

@export var initialForce = 100.00
@onready var forwardDirection = $Marker3D
