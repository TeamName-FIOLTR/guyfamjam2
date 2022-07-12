extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var random_data : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_player_stuff():
	var vel = $Player.angular_velocity
	var label_string = ""
	label_string += "Angular Velocity: %s\n"%vel
	label_string += "Left Spin Speed: %s\n"%$Player.spin_speed_left
	label_string += "Right Spin Speed: %s"%$Player.spin_speed_right
	label_string += "\nSpinning Rate: %s Hz (%s RPM)"%[$Player.spinning_rate, $Player.spinning_rate*60]
	return label_string
func _process(delta):
	$Label.text = get_player_stuff()+"\n"
	for data in random_data.keys():
		$Label.text += "%s: %s\n"%[data, random_data[data]]
	
#	pass

func recieve_arbitrary_data(data_string, data_value):
	random_data[data_string] = data_value
