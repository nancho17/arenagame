extends Camera3D

var camera_zoom : int = 0
var original_pos
var original_rot
var original_transform
var MAX_ZOOM : int = 450

var pos_h : float = 0
var pos_v : float = 0
var rot_y : float = 0

const DELTA_H : float = 10.0
const DELTA_V : float = 10.0
const DELTA_ROT : float = 2.1
const DELTA_ZOOM : int = 5

const camera_rot_y : float = 0.31*PI#0.24*PI#0.34*PI
var geo_vec := Vector3.ZERO 
var not_received_in_gui = false 


func _ready():
	camera_zoom = 10
	original_pos = get_position()
	transform = transform.rotated_local(Vector3(1,0,0),-camera_rot_y)
	original_transform = get_transform() 
	do_move()
	set_physics_process_priority(10)


func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		camera_zoom = -DELTA_ZOOM
		do_move()
	if event.is_action_pressed("zoom_out"):
		camera_zoom = DELTA_ZOOM
		do_move()
	
func _physics_process(delta):
#	var test_val = get_transform() * Vector3(0,0,10)
#	var atest = test_val * get_transform()
#	var apos = get_position()



	if Input.is_action_pressed("right_move_cam_map"):
		pos_h = (DELTA_H * delta)*(get_position().y*0.10)
		do_move()
	if Input.is_action_pressed("left_move_cam_map"):
		pos_h = - (DELTA_H * delta)*(get_position().y*0.10)
		do_move()
	if Input.is_action_pressed("up_move_cam_map"):
		pos_v=- (DELTA_V * delta)*(get_position().y*0.10)
		do_move()
	if Input.is_action_pressed("down_move_cam_map"):
		pos_v= (DELTA_V * delta)*(get_position().y*0.10)
		do_move()

	if Input.is_action_pressed("rot_wise_cam_map"):
		rot_y = -DELTA_ROT * delta
		do_move()
	if Input.is_action_pressed("rot_coun_cam_map"):
		rot_y = DELTA_ROT * delta
		do_move()

func do_move():
	#var zoom_pos = original_pos.y * (1+(camera_zoom*0.10))
	
	
	if get_global_position().length() > MAX_ZOOM:
		camera_zoom = clamp(camera_zoom,-50,0)
	if get_global_position().y < 10:
		camera_zoom = clamp(camera_zoom,0,50)

	
	transform = transform.translated_local(Vector3(0,0 , camera_zoom))
	transform = transform.rotated_local(Vector3(1,0,0),camera_rot_y)
	transform = transform.rotated_local(Vector3(0,1,0),rot_y)
	
	limit_space(transform)

	transform = transform.translated_local(Vector3(pos_h, 0, pos_v))
	transform = transform.rotated_local(Vector3(1,0,0),-camera_rot_y)

	pos_h = 0
	pos_v = 0
	rot_y = 0
	camera_zoom = 0

func limit_space(de_transform : Transform3D):

	var limit = de_transform * Vector3(pos_h, 0, pos_v)
	
	var delta = limit - get_position()
	if limit.x < -420 and delta.x < 0:
		pos_h=0
		pos_v=0
	if limit.x > 420 and delta.x > 0:
		pos_h=0
		pos_v=0

	if limit.z > 260 and delta.z > 0:
		pos_h=0
		pos_v=0
	if limit.z < -260 and delta.z < 0:
		pos_h=0
		pos_v=0

	#prints("a",pos_v,pos_h,"gp:",get_position().x)
