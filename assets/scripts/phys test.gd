extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var random_data : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
#	$Viewport.size = get_tree().root.size
#	$Camera.frustum_offset
	Engine.time_scale = 1
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


func _input(event):
	if event.is_action_pressed("ui_accept"):
		var screenshot_path = "res://thingy.png"
		var image = get_tree().get_root().get_texture().get_data()
		
		# Flip it on the y-axis (because it's flipped)
		image.flip_y()
		
		image.save_png(screenshot_path)
		yield(get_tree(),"idle_frame")
		yield(get_tree(),"idle_frame")
		yield(get_tree(),"idle_frame")
		yield(get_tree(),"idle_frame")
		yield(get_tree(),"idle_frame")
		yield(get_tree(),"idle_frame")
		get_tree().paused = !get_tree().paused
