extends KinematicBody2D


const SPEED = 200
onready var motion = Vector2.ZERO
var can_fire = true
onready var screensize = get_viewport_rect().size
var bullet_inst = preload("res://Level/Shoot.tscn")
 
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	motion_ctrl()
	motion = move_and_collide(motion * delta)
	
	if Input.is_action_pressed("ui_select") and can_fire:
		var bullet = bullet_inst.instance()
		bullet.global_position = $ShootSpawn.global_position
		bullet.rotation = rotation
		get_tree().root.add_child(bullet)
		can_fire = false
		yield(get_tree().create_timer(0.2), "timeout")
		can_fire = true


func get_axis() -> Vector2: #obtener ejes
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis

func motion_ctrl():
	if get_axis() == Vector2.ZERO:
		motion = Vector2.ZERO
	else:
		motion = get_axis().normalized() * SPEED
	
	#limitar movimiento
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)

func kill():
	get_tree().reload_current_scene()
