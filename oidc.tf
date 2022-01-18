data "azuread_client_config" "current" {}
data "azurerm_subscription" "current" {}

#Azure AD application for github
resource "azuread_application" "github" {
  display_name = "github-actions-pipeline-app"
  owners       = [data.azuread_client_config.current.object_id]
  web {
    redirect_uris = []
    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = true
    }
  }
}
#Azure Federated Creds for GitHub using OIDC
resource "azuread_application_federated_identity_credential" "github" {
  application_object_id = azuread_application.github.object_id
  display_name          = "github-actions-pipeline-creds"
  description           = "Deployments from GitHub ${var.organization} ${var.repository_name}"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:${var.organization}/${var.repository_name}:${var.repository_branch_or_env}"
}
# Create an Azure AD service principal for github Open ID Connect
resource "azuread_service_principal" "github" {
  application_id                = azuread_application.github.application_id
  alternative_names             = ["github-actions-pipeline-app"]
  preferred_single_sign_on_mode = "oidc"
  description                   = "Service principle for execution from Github"
  owners                        = [data.azuread_client_config.current.object_id]
}
resource "azurerm_role_assignment" "github" {
  scope                = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.github.object_id
}