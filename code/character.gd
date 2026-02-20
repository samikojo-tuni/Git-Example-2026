extends CharacterBody2D


@export var _speed : float = 300.0
@export var _jump_velocity : float = -400.0
@export var _max_health : int = 3

var _dash_timer : float = 0
var _health : int = 3

func take_damage(amount : int) -> void:
	_health = clamp(_health - amount, 0, _max_health)
	
func heal(amount: int) -> void:
	_health = clamp(_health + amount, 0, _max_health)
	
func _die() -> void:
	# TODO: Implement this!
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _jump_velocity
	
	if Input.is_action_just_pressed("dash"):
		_dash_timer = 0.25

	if _dash_timer > 0:
		_dash_timer = clamp(_dash_timer - delta, 0, _dash_timer)
		velocity.x = _speed * 3
	
	else:
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * _speed
		else:
			velocity.x = move_toward(velocity.x, 0, _speed)

	move_and_slide()
