provider "azurerm" {
  features {}
}

provider "azuread" {
  tenant_id = var.azuread_tenant_id
}