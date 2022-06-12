provider "azurerm" {
  features {}
}

locals {
  name_suffix = "dev"
  tags = {
    "managed"     = "terraformed"
    "owner"       = "smekarthick2005@gmail.com"
    "environment" = "${local.name_suffix}"
  }
}


resource "azurerm_resource_group" "resource_group" {
  name     = local.name_suffix
  location = "East US"
  tags     = local.tags
}


resource "azurerm_mysql_server" "mysql_server" {
  name                = "db01-mysqlserver-${local.name_suffix}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  administrator_login          = "mysqladminun"
  administrator_login_password = "H@Sh1CoR3!"

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = true
  infrastructure_encryption_enabled = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
  public_network_access_enabled     = true
}

resource "azurerm_mysql_database" "mysql_db" {
  name                = "db01-${local.name_suffix}"
  resource_group_name = azurerm_resource_group.resource_group.name
  server_name         = azurerm_mysql_server.mysql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_firewall_rule" "db_firewall" {
  name                = "office-${local.name_suffix}"
  resource_group_name = azurerm_resource_group.resource_group.name
  server_name         = azurerm_mysql_server.mysql_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}


resource "azurerm_kubernetes_cluster" "example" {
  name                = "aks-${local.name_suffix}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = "aks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = local.name_suffix
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}
