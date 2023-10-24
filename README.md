# Azure Static Web App AAD authentication and AAD group based authorization

This repo is a Proof Of Concept of the complete deployment of an Azure Static Web App using Terraform and Azure DevOps.

The Azure Static Web App is using Single Sign On principle using Azure Active Directory (now Microsoft Entra ID) authentication.

Authorization is also configured using staticwebapp.config.json configuration file roles.

Roles used by the Azure Static Web App are mapped to existing Azure Active Directory groups to which the authenticated user belongs using an API called during the authentication process.
