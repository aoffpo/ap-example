output "env_resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "var_resource_group_name" {
  value = var.resource_group_name
}