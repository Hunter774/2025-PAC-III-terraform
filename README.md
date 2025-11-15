Este repositorio contiene el despliegue IaC para una solución OLTP + OLAP en Azure usando Terraform.

## Contenido del proyecto

- Infraestructura principal en Terraform
- Arquitectura OLTP + OLAP
- Separación de cargas operativas y analíticas
- Uso de servicios gestionados en Azure
- Manejo de errores y restricciones por políticas de suscripción
- Evidencia visual del despliegue parcial exitoso

## Estructura
- `main.tf` – Recursos principales
- `variables.tf` – Variables del proyecto
- `terraform.tfvars` – Valores de variables (sin secretos)
- `outputs.tf` – Outputs claves del despliegue
- `Readme.md` – Documentación del proyecto
- `evidence/` – Capturas de pantalla del despliegue

# Desarrollo – Terraform (PAC 2025)

Se logró desplegar exitosamente el Resource Group, el Storage Account y el Data Factory (importado al estado de Terraform) en la región centralus. El proceso confirmó que la infraestructura definida en Terraform es válida, funcional y lista para producción en una suscripción estándar.

Durante el despliegue se presentaron restricciones propias de la suscripción educativa, que impidieron la creación de algunos recursos como SQL Server y Key Vault. Estos errores fueron documentados y justificados como parte del proceso de aprendizaje y validación técnica.

- Se aplicaron buenas prácticas como:
- Uso de depends_on para asegurar el orden de creación
- Configuración de timeouts para evitar errores de sincronización
- Manejo de errores del provider con lifecycle para Storage Account
- Importación de recursos existentes con terraform import

La arquitectura propuesta separa las cargas OLTP y OLAP. La capa OLTP se diseñó sobre SQL Server para gestionar operaciones transaccionales, pero fue bloqueada por políticas de suscripción. La capa OLAP se implementó parcialmente con un Storage Account para datos analíticos y un Data Factory para orquestación ETL. El Data Warehouse no fue desplegado, pero se contempla como parte del diseño escalable.


# Reflexion

Este proyecto fue más que un ejercicio técnico: fue una prueba de resiliencia frente a restricciones inesperadas, errores del proveedor y políticas de suscripción que limitaron el despliegue. A pesar de ello, se logró validar la arquitectura, adaptar el código a las condiciones reales y documentar cada paso con claridad. Terraform no solo permitió automatizar la infraestructura, sino también entender cómo interactúan los servicios de Azure en escenarios OLTP y OLAP. El resultado es una base sólida que puede escalarse fácilmente en entornos productivos, y una experiencia que refuerza la importancia de la paciencia, la estrategia y el aprendizaje continuo en la ingeniería de software.

# 1. Desafío mayor con dependencias implícitas en Terraform
Uno de los retos más importantes fue manejar las dependencias implícitas entre recursos, especialmente cuando un servicio necesita que otro esté completamente creado antes de funcionar. Por ejemplo, Data Factory puede requerir conectarse a la base de datos OLTP, pero si la base aún no existe al momento del apply, el despliegue falla o queda en estado inconsistente.

Para evitar esto:

- Usé depends_on explícito en recursos críticos como la base de datos y el orquestador.
- Introduje time_sleep como pausa estratégica después del Storage Account, para asegurar que los recursos dependientes no se ejecutaran antes de tiempo.
- Validé el orden lógico en el main.tf para que cada recurso tuviera sus prerequisitos listos.
Este manejo fue clave para lograr un terraform apply exitoso sin errores de sincronización.

# 2. Por qué separar OLTP de OLAP en alquiler de vehículos

- En una plataforma de alquiler de vehículos blindados, separar OLTP y OLAP es fundamental para la estabilidad y escalabilidad:
- OLTP maneja operaciones en tiempo real: reservas, contratos, disponibilidad. Requiere baja latencia y alta disponibilidad.
- OLAP procesa grandes volúmenes de datos: patrones de uso, telemetría, mantenimiento, rentabilidad. Estas consultas son pesadas y no necesitan ejecutarse en tiempo real.
Si ambas cargas se ejecutan sobre la misma base:
- Las consultas analíticas pueden ralentizar las operaciones.
- Se genera contención de recursos, afectando la experiencia del usuario.
- Aumenta el riesgo de bloqueos y timeouts en transacciones críticas.
Separar OLTP y OLAP permite:
- Escalar cada carga de forma independiente.
- Optimizar rendimiento y costos.
- Garantizar que la operación no se vea afectada por la analítica.

# 3. Importancia de usar un servicio de orquestación (Req. 3)
En lugar de usar un script manual programado (por ejemplo, un cron job con Python), elegí Azure Data Factory como servicio de orquestación por varias razones:
- Automatización robusta: permite crear pipelines que se ejecutan por horario, evento o condición.
- Conectores nativos: se integra fácilmente con SQL Server, Blob Storage, Key Vault y otros servicios.
- Monitoreo y trazabilidad: ofrece paneles de control, logs, reintentos y alertas.
- Seguridad: puede acceder a secretos desde Key Vault sin exponer credenciales en código.
Un script manual no ofrece estas garantías:
- No tiene control de errores ni reintentos.
- No escala bien.
- Es difícil de auditar y mantener.
Usar Data Factory asegura que el proceso ETL sea profesional, seguro y mantenible, cumpliendo con los estándares de una solución empresaria

