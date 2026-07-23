PROYECTO 6 - Gas Operations Field BI
Dataset: Ordenes de servicio técnicos de campo - Gas natural
Periodo: Diciembre 2025 - Febrero 2026
Registros: 7.643 | Técnicos: 40
Efectividad global: 66.15%
=====================================

PERSPECTIVA DIRECTOR DE OPERACIONES
-------------------------------------
P1 - Efectividad por centro de planificacion:
→ Global: 66.15%
→ Bogota (1501): 62.83% (5.636 ordenes)
→ Cundinamarca/Boyaca (2401): 75.49% (2.007 ordenes)
→ Insight: menor volumen pero mayor efectividad en zona rural
→ Hipotesis: factor cultural de acceso al predio en Bogota

SELECT
    [Centro planificación],
    COUNT(*) AS total_ordenes,
    SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) AS efectivas,
    SUM(CASE WHEN Efectividad = 'No Efectiva' THEN 1 ELSE 0 END) AS no_efectivas,
    ROUND(SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS tasa_efectividad_pct
FROM [Efectividad tecnicos gas]
GROUP BY [Centro planificación]

UNION ALL

SELECT
    'GLOBAL' AS [Centro planificación],
    COUNT(*) AS total_ordenes,
    SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) AS efectivas,
    SUM(CASE WHEN Efectividad = 'No Efectiva' THEN 1 ELSE 0 END) AS no_efectivas,
    ROUND(SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS tasa_efectividad_pct
FROM [Efectividad tecnicos gas]
ORDER BY total_ordenes DESC;


P2 - Efectividad por tecnico y centro:
→ 1501 Bogota: mayor dispersion (43% - 82%) problema de gestion individual
→ 2401 Cund/Boyaca: mas homogeneo (63% - 87%)
→ Volumen de ordenes no determina efectividad
→ Insight: Técnico(304 ordenes, 43.42%) requiere atencion inmediata
→ Insight: Técnico(560 ordenes, 75.36%) es referente operacional
→ Recomendacion: plan de mejora individual para técnicos bajo 55% en 1501

SELECT
    [Centro planificación],
    [Nombre del técnico ODS],
    COUNT(*) AS total_ordenes,
    SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) AS efectivas,
    SUM(CASE WHEN Efectividad = 'No Efectiva' THEN 1 ELSE 0 END) AS no_efectivas,
    ROUND(SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS tasa_efectividad_pct
FROM [Efectividad tecnicos gas]
GROUP BY [Centro planificación], [Nombre del técnico ODS]
HAVING COUNT(*) > 10
ORDER BY [Centro planificación], tasa_efectividad_pct DESC;

P3 - Tipo de trabajo con mas no efectivas:
→ J60: 2.05% efectividad - cliente rechaza cobro elevado
→ J30: 11.11% - agendados por Vanti sin coordinacion con usuario
→ K10: 42.16% - mayor volumen de no efectivas en terminos absolutos(627) - visitas derivadas de desviaciones de lectura, usuario no avisado. Cambio de proceso en terreno durante el periodo afecto efectividad K10
→ J10: 62.48% con 1.703 ordenes - tipo de trabajo mas frecuente
→ W10: 76.21% con 1.299 ordenes - buen desempeño en alto volumen
→ Tipos derivados (J63, J80, K60 etc.) excluir de analisis final
→ Insight: problema no es operacional sino comercial en J60 y J30
→ Recomendación: revisar politica de agendamiento de distribuidora de gas para J30

SELECT
    [Clase actividad PM],
    COUNT(*) AS total_ordenes,
    SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) AS efectivas,
    SUM(CASE WHEN Efectividad = 'No Efectiva' THEN 1 ELSE 0 END) AS no_efectivas,
    ROUND(SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS tasa_efectividad_pct
FROM [Efectividad tecnicos gas]
GROUP BY [Clase actividad PM]
ORDER BY tasa_efectividad_pct ASC;

P4 - Evolucion mensual de efectividad:
→ Dic 2025: 67.42% (3.115 ordenes)
→ Ene 2026: 66.87% (2.430 ordenes)
→ Feb 2026: 63.44% (2.098 ordenes)
→ Tendencia: caida sostenida de 4 puntos en 3 meses
→ Contexto: cambios operativos en terreno impactaron negativamente y factores externos adicionales influyeron en la caida
→ Recomendacion: revertir cambios operativos o implementar plan de contingencia

SELECT
    SUBSTR([Fecha de Ejecución (Fin)], -7, 2) AS mes_num,
    SUBSTR([Fecha de Ejecución (Fin)], -4) AS año,
    SUBSTR([Fecha de Ejecución (Fin)], -7, 2) || '/' || SUBSTR([Fecha de Ejecución (Fin)], -4) AS mes,
    COUNT(*) AS total_ordenes,
    SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) AS efectivas,
    SUM(CASE WHEN Efectividad = 'No Efectiva' THEN 1 ELSE 0 END) AS no_efectivas,
    ROUND(SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS tasa_efectividad_pct
FROM [Efectividad tecnicos gas]
GROUP BY mes
ORDER BY año, mes_num

PERSPECTIVA GERENTE GENERAL
-------------------------------------
P5 - Municipio con mas no efectivas:
→ Bogota: 2.018 no efectivas - mayor volumen absoluto y peor tasa (62.46%)
→ Municipios Cund/Boyaca: tasas entre 73% y 89% - significativamente mejores
→ Hipotesis confirmada: factor cultural de seguridad en Bogota
→ Excepcion: La Calera (25%): problema de desplazamiento vs volumen de ordenes- costo logistico alto para pocas ordenes diarias
→ Nemocon (28.57%): sin contexto operacional identificado
→ Mejor desempeño: Duitama 89.29%, Facatativa 88.78%
→ Recomendacion Bogota: confirmacion previa de visita, identificacion 
   visible del tecnico, reagendamiento inmediato en campo
→ Recomendacion La Calera: agrupacion minima de 3-4 ordenes 
   por zona antes de desplazar tecnico
→ Estrategia diferenciada: no gestionar Bogota igual que municipios pequenos porque los factores de no efectividad son distintos

SELECT
    [D_Municipio],
    COUNT(*) AS total_ordenes,
    SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) AS efectivas,
    SUM(CASE WHEN Efectividad = 'No Efectiva' THEN 1 ELSE 0 END) AS no_efectivas,
    ROUND(SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS tasa_efectividad_pct
FROM [Efectividad tecnicos gas]
GROUP BY [D_Municipio]
ORDER BY no_efectivas DESC

P6 - Mercado residencial vs comercial:
→ Industria No Regulado: 83.02% - mejor tasa (bien agendados)
→ Industria Regulado: 42.11% - peor tasa (cancelaciones de ultimo momento)
→ Residencial Saturacion: 68.64% con 4.486 ordenes - mayor volumen y buena efectividad
→ Residencial Nueva Edificacion: 56.05% - usuarios nuevos sin cultura de servicio
→ Comercial: 67.29% - por debajo de residencial saturacion
→ Insight: el agendamiento previo es el factor diferenciador, no el tipo de mercado
→ Recomendacion: replicar proceso de agendamiento industrial en segmento comercial

SELECT
    [D_Mercado],
    COUNT(*) AS total_ordenes,
    SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) AS efectivas,
    SUM(CASE WHEN Efectividad = 'No Efectiva' THEN 1 ELSE 0 END) AS no_efectivas,
    ROUND(SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS tasa_efectividad_pct
FROM [Efectividad tecnicos gas]
GROUP BY [D_Mercado]
ORDER BY tasa_efectividad_pct DESC;

P7 - Tipo de servicio con peor desempeno:
→ ODS Reconexion Pre-Cese: 16.22% - decision de negocio no operacional
→ Suspension temporal: 26.79% - ODS mal generada por empresa
→ Visita integral K10: 52.78% - usuario no notificado (falla de proceso empresa)
→ Reparacion/Polietileno a la vista: 49.61% - confirmacion hipotesis resane
→ Insight clave: separar no efectividad operacional vs sistémica
→ No efectividad sistémica: responsabilidad de procesos internos empresa
→ No efectividad operacional: mejora gestionable por Director de Operaciones
→ Recomendacion: clasificar ODS por tipo de no efectividad para medir desempeño real del equipo tecnico sin distorsion de factores externos

SELECT
    [D_Prod._Serv],
    COUNT(*) AS total_ordenes,
    SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) AS efectivas,
    SUM(CASE WHEN Efectividad = 'No Efectiva' THEN 1 ELSE 0 END) AS no_efectivas,
    ROUND(SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS tasa_efectividad_pct
FROM [Efectividad tecnicos gas]
GROUP BY [D_Prod._Serv]
HAVING COUNT(*) > 10
ORDER BY tasa_efectividad_pct ASC

P8 - Ranking tecnicos por volumen y efectividad:
→ Ranking separado por centro de planificacion (justo operacionalmente)
→ 1501 referente real: Milton Alarcon (rank 3 efectividad, rank 1 volumen)
→ 1501 caso critico: Leandro Mejia (ultimo en efectividad 43.42%, rank alto volumen)
→ Insight: ranking de efectividad sin considerar volumen puede ser engañoso
→ Recomendacion: evaluar tecnicos combinando ambos rankings, no solo tasa de efectividad

WITH tecnico_stats AS (
    SELECT
        [Nombre del técnico ODS],
        [Centro planificación],
        COUNT(*) AS total_ordenes,
        SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) AS efectivas,
        SUM(CASE WHEN Efectividad = 'No Efectiva' THEN 1 ELSE 0 END) AS no_efectivas,
        ROUND(SUM(CASE WHEN Efectividad = 'Efectiva' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS tasa_efectividad_pct
    FROM [Efectividad tecnicos gas]
    GROUP BY [Nombre del técnico ODS], [Centro planificación]
    HAVING COUNT(*) > 10
),
ranked AS (
    SELECT
        *,
        RANK() OVER (PARTITION BY [Centro planificación] ORDER BY tasa_efectividad_pct DESC) AS ranking_efectividad,
        RANK() OVER (PARTITION BY [Centro planificación] ORDER BY total_ordenes DESC) AS ranking_volumen
    FROM tecnico_stats
)
SELECT
    ranking_efectividad,
    [Centro planificación],
    [Nombre del técnico ODS],
    total_ordenes,
    ranking_volumen,
    efectivas,
    no_efectivas,
    tasa_efectividad_pct
FROM ranked
ORDER BY [Centro planificación], ranking_efectividad;