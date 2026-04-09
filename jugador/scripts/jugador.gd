extends CharacterBody2D
@export_category("variables movimientos")
@export var movimiento_velocidad = 120.0
@export var desaceleracion = 0.1
@export var gravedad = 500.0

var movimiento = Vector2()
var ultima_direccion = 1

@export_category("variable salto")
@export var velocidad_salto = 190.0
@export var aceleracion = 290.0
@export var cantidad_salto= 2

@export_category("dash")
@export var dash_velocidad = 400.0
@export var dash_duracion = 0.2

var puede_dashear = true
var esta_dasheando = false

func _physics_process(delta: float) -> void:
	if velocity.y > 0:
		velocity.y += gravedad * 1.3 * delta  
	else:
		velocity.y += gravedad * delta
	
	movimiento_horizontal()
	logica_salto()
	logica_dash()
	set_animations()
	flip()
	move_and_slide()

func movimiento_horizontal():
	movimiento = Input.get_axis("movimiento_izquierda","movimiento_derecha")
	if esta_dasheando:
		return
	if movimiento:
		velocity.x = movimiento * movimiento_velocidad
		ultima_direccion = movimiento
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
		cantidad_salto = 2 
		puede_dashear = true
	
	if Input.is_action_just_pressed("salto") and cantidad_salto > 0:
		velocity.y = -velocidad_salto
		cantidad_salto -= 1
	
	
	if Input.is_action_just_released("salto") and velocity.y < 0:
		velocity.y *= 0.4

func logica_dash():
	if Input.is_action_just_pressed("dash") and puede_dashear:
		esta_dasheando = true
		puede_dashear = false
		
		var direccion = Input.get_axis("movimiento_izquierda","movimiento_derecha")
		if direccion == 0:
			direccion = ultima_direccion
		
		velocity.x = direccion * dash_velocidad
		velocity.y = 0
		
		await get_tree().create_timer(dash_duracion).timeout
		
		esta_dasheando = false
