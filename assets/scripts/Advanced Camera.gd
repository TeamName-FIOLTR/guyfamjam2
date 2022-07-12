extends Camera


export(NodePath) var masking_camera_path
onready var masking_camera = get_node(masking_camera_path)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func update_camera(target_camera : Camera):
	target_camera.fov = fov
#	target_camera.projection = projection ## Keeping it perspective for now
	target_camera.global_transform = global_transform
	target_camera.keep_aspect = keep_aspect

# Called when the node enters the scene tree for the first time.
func _ready():
#	(masking_camera as Camera)
#	self.get_frustum()
#	self.get_camera_transform()
	$Viewport.size = get_viewport().size
#	self.set_frustum()
#	connect()
	VisualServer.connect("frame_pre_draw", self,"_on_frame_pre_draw")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_frame_pre_draw():
#	print("frame channnge")
	update_camera(masking_camera)
