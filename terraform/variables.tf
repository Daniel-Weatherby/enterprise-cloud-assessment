variable "resource_group_name" {
  description = "Name of the pre-created Azure resource group used by the assessment."
  type        = string
  default     = "rg-enterprise-cloud-assessment"
}

variable "location" {
  description = "Azure region for the workload."
  type        = string
  default     = "australiaeast"
}

variable "project_name" {
  description = "Short project identifier used in resource naming and tags."
  type        = string
  default     = "entcloud"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Common Azure resource tags."
  type        = map(string)

  default = {
    managed-by = "terraform"
    workload   = "acu-assessment"
  }
}
