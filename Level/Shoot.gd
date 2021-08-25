extends RigidBody2D

func _physics_process(delta):
	apply_impulse(Vector2(), Vector2(500, 0).rotated(rotation))

func _ready():
	$SoundShoot.play()
