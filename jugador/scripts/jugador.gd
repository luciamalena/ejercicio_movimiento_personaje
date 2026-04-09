extends CharacterBody2D
@export_category("variables movimientos")
@export var movimiento_velocidad = 120.0
@export var desaceleracion = 0.1
@export var gravedad = 500.0

var movimiento = Vector2()

@export_category("variable salto")
@export var velocidad_salto = 190.0
@export var aceleracion = 290.0
@export var cantidad_salto= 2

func _physics_process(delta: float) -> void:
	if velocity.y > 0:
		velocity.y += gravedad * 1.3 * delta  
	else:
		velocity.y += gravedad * delta
	
	movimiento_horizontal()
	logica_salto()
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
		
func logica_salto():
	if is_on_floor():
		cantidad_salto = 1  
	
	if Input.is_action_just_pressed("salto") and cantidad_salto > 0:
		velocity.y = -velocidad_salto
		cantidad_salto -= 1
	
	
	if Input.is_action_just_released("salto") and velocity.y < 0:
		velocity.y *= 0.4
