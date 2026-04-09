extends CharacterBody2D

@export var movimiento_velocidad = 120.0
@export var desaceleracion = 0.1

var movimiento = Vector2()
func _physics_process(delta: float) -> void:
	movimiento_horizontal()
	
	move_and_slide()

func movimiento_horizontal():
	movimiento = Input.get_axis("movimiento_izquierda","movimiento_derecha")
	
	if movimiento:
		velocity.x = movimiento * movimiento_velocidad
	else:
		velocity.x = move_toward(velocity.x, 0, movimiento_velocidad * desaceleracion )
