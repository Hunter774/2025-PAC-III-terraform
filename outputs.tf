# -------------------------------
# Outputs principales del proyecto PAC III
# -------------------------------

# Resource Group
output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Nombre del Resource Group creado"
}

output "resource_group_id" {
  value       = azurerm_resource_group.rg.id
  description = "ID del Resource Group"
}

# Storage Account
output "storage_account_name" {
  value       = azurerm_storage_account.storage.name
  description = "Nombre del Storage Account"
}

output "storage_account_id" {
  value       = azurerm_storage_account.storage.id
  description = "ID del Storage Account"
}

# SQL Server
output "sql_server_name" {
  value       = azurerm_mssql_server.sql.name
  description = "Nombre del servidor SQL"
}

output "sql_server_id" {
  value       = azurerm_mssql_server.sql.id
  description = "ID del servidor SQL"
}

# OLTP Database
output "oltp_db_name" {
  value       = azurerm_mssql_database.oltp.name
  description = "Nombre de la base de datos OLTP"
}

output "oltp_db_id" {
  value       = azurerm_mssql_database.oltp.id
  description = "ID de la base de datos OLTP"
}

# Data Factory
output "data_factory_name" {
  value       = azurerm_data_factory.df.name
  description = "Nombre del Data Factory"
}

output "data_factory_id" {
  value       = azurerm_data_factory.df.id
  description = "ID del Data Factory"
}
