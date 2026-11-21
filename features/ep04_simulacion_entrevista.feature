# language: es
@EP04 @core
Característica: Simulación de entrevista por voz con feedback
  Como candidato
  quiero practicar una entrevista con un entrevistador virtual y recibir feedback objetivo
  para saber qué corregir antes de una entrevista real

  Antecedentes:
    Dado que el candidato inició sesión y aceptó el consentimiento de datos personales
    Y tiene un puesto objetivo principal elegido

  # ---------------------------------------------------------------- US10
  @US10
  Escenario: Realizar la simulación por voz
    Dado que el candidato concedió permiso al micrófono
    Cuando inicia la simulación
    Entonces el entrevistador virtual formula entre 6 y 8 preguntas
    Y muestra audio y transcripción en tiempo real

  @US10
  Escenario: Repregunta según la respuesta
    Dado que la simulación está en curso
    Cuando el candidato responde una pregunta de forma incompleta
    Entonces el entrevistador puede formular una repregunta relacionada con su respuesta

  @US10
  Escenario: Pausar o terminar en cualquier momento
    Dado que la simulación está en curso
    Cuando el candidato pulsa "Pausar"
    Entonces la simulación se detiene sin perder las respuestas anteriores
    Cuando el candidato pulsa "Terminar"
    Entonces la simulación finaliza y se genera el feedback con lo respondido

  @US10
  Escenario: Responder por texto si no hay permiso de micrófono
    Dado que el candidato no concedió permiso al micrófono
    Cuando inicia la simulación
    Entonces la app ofrece responder por texto
    Y la simulación continúa con el mismo número de preguntas

  # ---------------------------------------------------------------- US11
  @US11
  Esquema del escenario: Feedback con puntaje de 1 a 5 por aspecto
    Dado que el candidato terminó una simulación
    Cuando recibe el feedback
    Entonces el aspecto "<aspecto>" muestra un puntaje entre 1 y 5

    Ejemplos:
      | aspecto                  |
      | Contenido (método STAR)  |
      | Claridad                 |
      | Muletillas               |
      | Ritmo al hablar          |

  @US11
  Escenario: El feedback incluye sugerencias concretas con ejemplo
    Dado que el candidato terminó una simulación
    Cuando recibe el feedback
    Entonces ve 3 sugerencias concretas
    Y cada sugerencia incluye un ejemplo de cómo mejorar la respuesta

  @US11
  Escenario: El feedback se entrega en menos de 30 segundos
    Dado que el candidato finaliza la simulación
    Entonces el feedback está disponible en menos de 30 segundos

  # ---------------------------------------------------------------- US12
  @US12
  Escenario: Preguntas adaptadas a las brechas del candidato
    Dado que el candidato tiene brecha crítica en "Comunicación efectiva" y "Python"
    Y el banco contiene al menos 80 preguntas etiquetadas por puesto y competencia
    Cuando inicia una simulación para "Analista de datos Junior"
    Entonces al menos 60 % de las preguntas apuntan a competencias con brecha
    Y todas las preguntas corresponden al puesto y a la empresa elegidos

  # ---------------------------------------------------------------- US13
  @US13
  Escenario: Historial y evolución de simulaciones
    Dado que el candidato realizó las siguientes simulaciones
      | fecha      | puesto objetivo          | puntaje |
      | 2026-11-02 | Analista de datos Junior | 2.8     |
      | 2026-11-09 | Analista de datos Junior | 3.4     |
      | 2026-11-16 | Analista de datos Junior | 3.9     |
    Cuando abre su historial
    Entonces ve cada simulación con fecha, puesto objetivo y puntaje
    Y un gráfico muestra la tendencia ascendente de los resultados

  # ---------------------------------------------------------------- US20
  @US20
  Escenario: El análisis de lenguaje corporal viene desactivado
    Cuando el candidato abre la configuración de la simulación
    Entonces la opción "Análisis de lenguaje corporal" está desactivada

  @US20
  Escenario: Activar la cámara requiere consentimiento explícito
    Dado que el candidato activa el análisis de lenguaje corporal
    Cuando todavía no aceptó el consentimiento de cámara
    Entonces el sistema muestra el consentimiento y no enciende la cámara hasta su aceptación

  @US20
  Escenario: El video no se almacena y se reportan métricas
    Dado que el candidato aceptó el consentimiento de cámara
    Cuando termina la simulación
    Entonces el reporte muestra puntajes de contacto visual, postura y gestos
    Y el video no queda almacenado, solo las métricas

  @US20
  Escenario: Sin lenguaje corporal el resto funciona igual
    Dado que el candidato no activó el análisis de lenguaje corporal
    Cuando realiza la simulación
    Entonces recibe el feedback de contenido, claridad, muletillas y ritmo
