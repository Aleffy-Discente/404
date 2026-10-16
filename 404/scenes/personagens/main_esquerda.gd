extends CharacterBody2D

const SPEED = 100.0

enum Eixo {
	X,
	Y
}

var ultimo_eixo = Eixo.X

@onready var sprite = $AnimatedSprite2D


func _physics_process(_delta: float) -> void:
	var x = Input.get_axis("ui_esquerda", "ui_direita")
	var y = Input.get_axis("ui_cima", "ui_baixo")


	# Descobre qual eixo foi pressionado por último.
	if Input.is_action_just_pressed("ui_esquerda") or Input.is_action_just_pressed("ui_direita"):
		ultimo_eixo = Eixo.X

	if Input.is_action_just_pressed("ui_cima") or Input.is_action_just_pressed("ui_baixo"):
		ultimo_eixo = Eixo.Y


	# Se os dois eixos estiverem ativos, mantém somente o último.
	if x != 0 and y != 0:
		if ultimo_eixo == Eixo.X:
			y = 0
		else:
			x = 0


	var direcao = Vector2(x, y)

	velocity = direcao * SPEED


	if direcao.x < 0:
		sprite.play("andando_esquerda")
	elif direcao.x > 0:
		sprite.play("andando_direita")
	elif direcao.y < 0:
		sprite.play("andando_cima")
	elif direcao.y > 0:
		sprite.play("andando_baixo")
	else:
		sprite.play("parado")


	move_and_slide()
