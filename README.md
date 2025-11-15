# Plataforma de Renta de Vehículos Blindados – Terraform (PAC 2025)

Este repositorio contiene el despliegue IaC para una solución OLTP + OLAP en Azure usando Terraform.

## Contenido del proyecto
- Infraestructura principal en Terraform
- Arquitectura OLTP + OLAP
- Separación de cargas operativas y analíticas
- Uso de servicios gestionados en Azure

## Estructura
- `main.tf` – Recursos principales
- `variables.tf` – Variables del proyecto
- `terraform.tfvars` – Valores de variables (sin secretos)
- `outputs.tf` – Outputs claves del despliegue
- `evidence/` – Capturas de pantalla del despliegue

-Se logró desplegar exitosamente el Resource Group y el Storage Account en la región centralus. El proceso confirmó que la infraestructura definida en Terraform es válida y funcional. Algunos recursos como SQL Server y Key Vault fueron bloqueados por políticas de la suscripción educativa, lo cual fue documentado con los errores correspondientes. El código está listo para producción en una suscripción estándar.
