extends RigidBody


export(float) var spin_left
export(float) var spin_right
export(Vector2) var input_vector
export(float) var angle_collision_switch_threashold = 30
export(NodePath) var spinner_collision_node_path
export(NodePath) var fast_spinner_collision_node_path
export(NodePath) var spinner_velocity_mesh_path


onready var spinner_collision : CollisionShape = get_node(spinner_collision_node_path)
onready var fast_spinner_collision : CollisionShape = get_node(fast_spinner_collision_node_path)
onready var spinner_velocity_mesh : MeshInstance = get_node(spinner_velocity_mesh_path)
onready var spinner_velocity_material = spinner_velocity_mesh.material_override

var spinning_rate = 0

var previous_spin_left = 0
var previous_spin_right = 0
var previous_time_us = 0

var spin_speed_left = 0
var spin_speed_right = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var delta_spin_left = spin_left-previous_spin_left
	var delta_spin_right = spin_right-previous_spin_right
	
	spin_speed_left = delta_spin_left/delta
	spin_speed_right = delta_spin_right/delta
	previous_spin_left = spin_left
	previous_spin_right = spin_right
	
	var applied_speed_left = max(0,spin_speed_left)
	var applied_speed_right = max(0,spin_speed_right)
	
	apply_torque_impulse(Vector3(0,1,0)*delta*(applied_speed_left-applied_speed_right))
	var local_rotational_velocity = global_transform.affine_inverse().basis*angular_velocity
	spinning_rate = local_rotational_velocity.y/(2*PI)
	if abs(360.0*spinning_rate*delta) >= angle_collision_switch_threashold and fast_spinner_collision.disabled:
		fast_spinner_collision.disabled = false
		spinner_collision.disabled = true
	elif abs(360.0*spinning_rate*delta) < angle_collision_switch_threashold and spinner_collision.disabled:
		spinner_collision.disabled = false
		fast_spinner_collision.disabled = true
	get_tree().call_group("Arbitrary Data Recievers", "recieve_arbitrary_data", "Spun Angle", 360*spinning_rate*delta)
	get_tree().call_group("Arbitrary Data Recievers", "recieve_arbitrary_data", "Spinner Collision", !spinner_collision.disabled)
	get_tree().call_group("Arbitrary Data Recievers", "recieve_arbitrary_data", "Fast Spinner Collision", !fast_spinner_collision.disabled)
	
	spinner_velocity_material.set_shader_param("angular_velocity", angular_velocity)


func _input(event):
	if event is InputEventJoypadMotion or event is InputEventKey:
		spin_left = Input.get_action_strength("spin_left")
		spin_right = Input.get_action_strength("spin_right")
		
		input_vector = Input.get_vector("move_left","move_right","move_backwards","move_forwards")
