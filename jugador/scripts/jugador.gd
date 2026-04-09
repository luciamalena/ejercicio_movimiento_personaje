extends CharacterBody2D

@export var movimiento_velocidad = 120.0
@export var desaceleracion = 0.1
@export var gravedad = 500.0

var movimiento = Vector2()
func _physics_process(delta: float) -> void:
	velocity.y += gravedad * delta 
	movimiento_horizontal()
	set_animations()
	flip()
	move_and_slide()

func movimiento_horizontal():
	movimiento = Input.get_axis("movimiento_izquierda","movimiento_derecha")
	
	if movimiento:
		velocity.x = movimiento * movimiento_velocidad
	else:
		velocity.x = move_toward(velocity.x, 0, movimiento_velocidad * desaceleracion )

func set_animations():
	if velocity.x != 0:
		$AnimationPlayer.play("movimiento")
	if velocity.x == 0:
		$AnimationPlayer.play("idle")
		
func flip():
	if velocity.x > 0.0:
		scale.x = scale.y * 1
	if velocity.x < 0.0:
		scale.x = scale.y * -1
