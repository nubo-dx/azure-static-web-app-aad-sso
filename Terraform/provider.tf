terraform {
  required_version = ">=1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.76.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.44.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "= 0.9.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
