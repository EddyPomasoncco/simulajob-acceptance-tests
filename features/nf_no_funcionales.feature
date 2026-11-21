# language: es
@NF
Característica: Requisitos no funcionales de SimulaJob
  Como usuario
  quiero que la plataforma sea rápida, segura, usable y esté disponible
  para practicar con confianza antes de mis entrevistas

  # ---------------------------------------------------------------- US22
  @US22 @rendimiento @EP04
  Escenario: Tiempo de respuesta del entrevistador virtual
    Dado que una simulación por voz está en curso
    Cuando el candidato deja de hablar
    Entonces el entrevistador responde en máximo 3 segundos en el percentil 95

  @US22 @rendimiento
  Esquema del escenario: Degradación bajo carga concurrente
    Dado que hay <simulaciones> simulaciones simultáneas
    Cuando se mide el tiempo de respuesta del entrevistador
    Entonces la degradación respecto a la línea base es menor al <límite> %

    Ejemplos:
      | simulaciones | límite |
      | 50           | 5      |
      | 100          | 10     |
      | 200          | 20     |

  # ---------------------------------------------------------------- US23
  @US23 @seguridad @EP05
  Esquema del escenario: Cifrado de datos
    Dado que el sistema maneja <dato>
    Entonces los datos están cifrados <estado> con <cifrado>

    Ejemplos:
      | dato                | estado       | cifrado          |
      | datos del perfil    | en tránsito  | TLS 1.2 o superior |
      | transcripciones     | en tránsito  | TLS 1.2 o superior |
      | datos del perfil    | en reposo    | AES-256          |
      | transcripciones     | en reposo    | AES-256          |

  @US23 @seguridad
  Escenario: No se conservan el audio ni el video originales
    Dado que el candidato terminó una simulación
    Cuando se completa el procesamiento
    Entonces el audio y el video originales se eliminan
    Y solo permanecen las transcripciones y las métricas

  @US23 @seguridad
  Escenario: Acceso por roles con registro de auditoría
    Dado que un usuario con rol "soporte" intenta leer las transcripciones de un candidato
    Cuando el sistema evalúa los permisos
    Entonces deniega el acceso
    Y registra el intento en el log de auditoría

  # ---------------------------------------------------------------- US24
  @US24 @usabilidad @EP05
  Esquema del escenario: Diseño adaptable a distintos anchos de pantalla
    Dado que el candidato abre SimulaJob en una pantalla de <ancho> px de ancho
    Entonces la interfaz se adapta sin desplazamiento horizontal

    Ejemplos:
      | ancho |
      | 360   |
      | 768   |
      | 1440  |

  @US24 @usabilidad
  Escenario: Accesibilidad nivel AA de WCAG 2.1
    Cuando se audita la interfaz del diagnóstico
    Entonces el contraste de texto cumple el nivel AA
    Y todas las acciones se pueden realizar con el teclado

  @US24 @usabilidad
  Escenario: Prueba de usabilidad con usuarios nuevos
    Dado que 5 usuarios nuevos prueban el diagnóstico sin ayuda
    Cuando se calcula el puntaje SUS promedio
    Entonces el puntaje es de al menos 70

  # ---------------------------------------------------------------- US25
  @US25 @disponibilidad @EP05
  Escenario: Disponibilidad mensual del servicio
    Dado que transcurrió un mes de operación
    Cuando se calcula la disponibilidad
    Entonces es de al menos 99 %

  @US25 @disponibilidad
  Escenario: Respaldos diarios de la base de datos
    Dado que son las 03:00 horas
    Cuando se ejecuta el proceso de respaldo
    Entonces se genera un respaldo de la base de datos
