terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.54.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
    
  }
}


terraform {
  backend "azurerm" {
    resource_group_name  = "rgstsidtest"
    storage_account_name = "mystsidtestqsoct5"
    container_name       = "tftstate"
    key                  = "terraformgithubexample.tfstate"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.locatoin
}

resource "azurerm_app_service_plan" "applan" {
  name                = var.appplanname
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app" {
  name                = var.appname
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.applan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}