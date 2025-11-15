# Plataforma de Renta de Vehículos Blindados – Terraform (PAC 2025)

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

El proyecto incluye evidencia visual del despliegue, diagramas de arquitectura, y reflexiones finales sobre los desafíos enfrentados y las soluciones implementadas.
