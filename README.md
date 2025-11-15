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
