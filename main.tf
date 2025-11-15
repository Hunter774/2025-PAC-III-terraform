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
  location = "centralus"   # region
}

# -------------------------------
# 2) Base de datos OLTP (SQL Server + DB)
# -------------------------------
resource "azurerm_mssql_server" "sql" {
  name                         = "${var.project_name}-sqlserver"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = "westus3"   # region
  version                      = "12.0"
  administrator_login          = var.sql_admin_user
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_mssql_database" "oltp" {
  name      = "${var.project_name}-oltp"
  server_id = azurerm_mssql_server.sql.id
  sku_name  = "S0"   # Tier permitido, no cambiar por Basic porque se jode >:v
}


# -------------------------------
# 3) Almacenamiento analítico (Blob Storage)
# -------------------------------
resource "azurerm_storage_account" "storage" {
  name                     = "vehiculosblindados1125"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = "centralus"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [azurerm_resource_group.rg]

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }

  lifecycle {
    ignore_changes = [
      primary_access_key,
      secondary_access_key
    ]
  }
}

# -------------------------------
# 4) Orquestación de datos (Data Factory)
# -------------------------------
resource "azurerm_data_factory" "df" {
  name                = "${var.project_name}-df"
  location            = "centralus"   # region fija
  resource_group_name = azurerm_resource_group.rg.name
}

# -------------------------------
# 5) Gestión de secretos (Key Vault)
# -------------------------------
resource "azurerm_key_vault" "kv" {
  name                        = "${var.project_name}-kv"
  location                    = "westus3"   # region fija
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"

  soft_delete_retention_days  = 7
  purge_protection_enabled    = true
}
