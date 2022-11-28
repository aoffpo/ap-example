output "env_resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "common_resource_group_name" {
  value = azurerm_resource_group.common.name
}