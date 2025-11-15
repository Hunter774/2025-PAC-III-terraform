resource "azurerm_mysql_flexible_server" "mysql" {
  name                = "mysql-renta-vehiculos-2025"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  administrator_login          = "adminw"
  administrator_password       = "Admin12345!"
  sku_name            = "B_Standard_B1s"

  storage {
    size_gb = 20
  }

  version = "8.0.21"

  backup {
    backup_retention_days = 7
  }
}

resource "azurerm_mysql_flexible_server_firewall_rule" "office" {
  name                = "allow-local-ip"
  resource_group_name = azurerm_mysql_flexible_server.mysql.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}
