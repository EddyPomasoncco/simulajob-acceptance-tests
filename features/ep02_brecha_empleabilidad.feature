# language: es
@EP02 @core
Característica: Perfil objetivo y análisis de brecha de empleabilidad
  Como candidato a un puesto
  quiero comparar mi perfil con el puesto y la empresa que elegí
  para saber qué necesito para que me contraten

  Antecedentes:
    Dado que el catálogo de perfiles objetivo contiene al menos 15 perfiles con su fuente pública

  # ---------------------------------------------------------------- US04
  @US04
  Escenario: Elegir un puesto y empresa objetivo marcando uno como principal
    Dado que el candidato completó su diagnóstico como invitado
    Cuando elige los siguientes perfiles objetivo
      | puesto                     | empresa o sector | principal |
      | Analista de datos Junior   | Banca            | sí        |
      | Desarrollador Backend Jr.  | Retail           | no        |
    Entonces el sistema guarda ambos objetivos
    Y marca "Analista de datos Junior" como objetivo principal
    Y muestra el aviso "Los requisitos son referenciales y no garantizan la contratación"

  @US04
  Escenario: No se permite elegir más de 3 objetivos
    Dado que el candidato ya eligió 3 perfiles objetivo
    Cuando intenta elegir un cuarto perfil
    Entonces el sistema rechaza la selección
    Y muestra el mensaje "Puedes elegir hasta 3 objetivos"

  @US04
  Escenario: Cada perfil objetivo muestra la fuente de sus requisitos
    Cuando el candidato abre el detalle del perfil "Analista de datos Junior" de "Banca"
    Entonces ve sus requisitos técnicos y blandos
    Y cada requisito indica la fuente de la oferta laboral pública

  # ---------------------------------------------------------------- US05
  @US05
  Esquema del escenario: Clasificar cada competencia según la brecha
    Dado que el candidato tiene nivel actual <actual> en la competencia "<competencia>"
    Y el perfil objetivo exige nivel <requerido> en esa competencia
    Cuando el sistema calcula el análisis de brecha
    Entonces muestra una brecha de <brecha> niveles
    Y clasifica la competencia como "<clasificación>"

    Ejemplos:
      | competencia            | actual | requerido | brecha | clasificación  |
      | SQL                    | 4      | 3         | 0      | Cumple         |
      | Estadística básica     | 3      | 3         | 0      | Cumple         |
      | Visualización de datos | 2      | 3         | 1      | Por reforzar   |
      | Comunicación efectiva  | 2      | 4         | 2      | Brecha crítica |
      | Python                 | 1      | 4         | 3      | Brecha crítica |

  @US05
  Escenario: Solicitar el diagnóstico antes de mostrar la brecha
    Dado que el candidato eligió un puesto objetivo
    Y todavía no realizó el diagnóstico
    Cuando abre el análisis de brecha
    Entonces el sistema le solicita completar el diagnóstico
    Y no muestra resultados vacíos

  # ---------------------------------------------------------------- US06
  @US06
  Esquema del escenario: Nivel de preparación para postular
    Dado que el promedio ponderado de sus competencias es <porcentaje> %
    Cuando el candidato consulta su nivel de preparación
    Entonces el sistema muestra el estado "<estado>"
    Y le ofrece "<acción>"

    Ejemplos:
      | porcentaje | estado               | acción                                |
      | 92         | Listo para postular  | ver ofertas y practicar la entrevista |
      | 80         | Listo para postular  | ver ofertas y practicar la entrevista |
      | 72         | Cerca de estar listo | ver las competencias que faltan       |
      | 60         | Cerca de estar listo | ver las competencias que faltan       |
      | 45         | Meta de crecimiento  | ir al plan de entrenamiento           |

  @US06
  Escenario: El porcentaje pondera 60 % técnicas y 40 % blandas
    Dado que el candidato tiene 80 % de promedio en competencias técnicas
    Y 50 % de promedio en competencias blandas
    Cuando el sistema calcula el nivel de preparación
    Entonces el porcentaje de preparación es 68 %
    Y se indican las 3 competencias que más pesan en el resultado

  # ---------------------------------------------------------------- US07
  @US07
  Escenario: Recomendaciones priorizadas por impacto en la brecha
    Dado que el candidato tiene 3 competencias con brecha crítica
    Cuando consulta qué necesita para que lo contraten
    Entonces recibe como máximo 5 acciones ordenadas por impacto
    Y cada acción muestra
      | campo                  |
      | competencia que mejora |
      | tiempo estimado        |
      | resultado esperado     |

  @US07
  Escenario: No se recomienda postular con preparación menor a 60 %
    Dado que el nivel de preparación del candidato es 48 %
    Cuando consulta sus recomendaciones
    Entonces el mensaje indica "Aún no se recomienda postular"
    Y muestra el tiempo estimado para llegar a 80 %

  # ---------------------------------------------------------------- US21
  @US21
  Escenario: Descargar el reporte de perfil y brecha en PDF
    Dado que el candidato tiene un análisis de brecha calculado
    Cuando solicita descargar el reporte
    Entonces el sistema genera un PDF en menos de 10 segundos
    Y el PDF incluye perfil, brecha por competencia, porcentaje de preparación y recomendaciones
