locals {
  location = "West Europe"
}

resource "random_pet" "rg_name" {
  prefix = "rg"
}

resource "random_password" "password" {
  length  = 16
  special = true
}

resource "azurerm_resource_group" "rg" {
  location = local.location
  name     = random_pet.rg_name.id
}

terraform {
  backend "azurerm" {
    resource_group_name  = "atm-infra"
    storage_account_name = "atmtstate"
    container_name       = "tstate"
    key                  = "L8J/THOEeAhY2WX28/ypc2mri7s+s7ZRCl8NqCLpQCTfHENbSt2nVEgbGX4PRvziQ9+3A57icxvp+AStD8DtLQ=="
  }

  required_providers {
    azurerm = {
      # Specify what version of the provider we are going to utilise
      source  = "hashicorp/azurerm"
      version = ">= 2.4.1"
    }
  }
}
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}
data "azurerm_client_config" "current" {}
# Create our Resource Group - Jonnychipz-RG
