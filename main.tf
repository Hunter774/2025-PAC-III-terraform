terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

# -------------------------------
# 1) Resource Group
# -------------------------------
resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-rg"
  location = var.location
}

# -------------------------------
# 2) Storage Account
# -------------------------------
# Corrección en main.tf:
resource "azurerm_storage_account" "storage" {
  name                     = replace("${var.project_name}stg", "-", "") 
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}
resource "time_sleep" "wait_storage" {
  depends_on      = [azurerm_storage_account.storage]
  create_duration = "30s"
}

# -------------------------------
# 3) SQL Server
# -------------------------------
resource "azurerm_mssql_server" "sql" {
  name                         = "${var.project_name}-sql"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_user
  administrator_login_password = var.sql_admin_password
}

# OLTP Database
resource "azurerm_mssql_database" "oltp" {
  name      = "${var.project_name}-oltp"
  server_id = azurerm_mssql_server.sql.id
  sku_name  = "S0"

  depends_on = [azurerm_mssql_server.sql]
}

# -------------------------------
# 4) Data Factory
# -------------------------------
resource "azurerm_data_factory" "df" {
  name                = "${var.project_name}-df"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  depends_on = [time_sleep.wait_storage]
}

# -------------------------------
# 5) Key Vault
# -------------------------------
resource "azurerm_key_vault" "kv" {
  name                        = "${var.project_name}-kv"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  depends_on = [time_sleep.wait_storage]
}
