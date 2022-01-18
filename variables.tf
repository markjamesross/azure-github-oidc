variable "env_name" {
  type        = string
  default     = "mgmt"
  description = "Environment name"
}
variable "deployment_tool" {
  type        = string
  default     = "terraform"
  description = "Tool used to deploy code"
}
variable "service_name" {
  description = "Name of the service"
  type        = string
  default     = "github-oidc"
}
variable "organization" {
  description = "Name of the GitHub Organization."
  type        = string
}
variable "repository_name" {
  description = "Name of the GitHub Repository."
  type        = string
}
variable "azure_region" {
  description = "Region to deploy to"
  type        = string
  default     = "uksouth"
}
variable "repository_branch_or_env" {
  description = "Details on which branch or environment to deploy to.  Environment needs to be in the format 'environment:<env_name>', branch needs to be in the format 'ref:refs/heads/<branch_name>'"
  type        = string
  default     = "ref:refs/heads/main"
}
variable "azuread_tenant_id" {
  description = "Azure AD tenant to deploy to"
  type        = string
}