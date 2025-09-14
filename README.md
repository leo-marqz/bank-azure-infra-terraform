# IaaC Con Terraform
## Infraestructura para el proyecto de microservicios bancarios (Bank Microservices with .Net 8)

### Configuraciones Iniciales
- Configuracion de la AZCLI
  - az account show
  - az account clear
  - az login --tenantId XXXXXXX-XXXX-XX
  - az account list-locations --output table
  - az ad sp create-for-rbac --name "sp-admin-dev-app" --role="Contributor" --scopes="/subscriptions/xxx-xxxx-xxxx-xxx"
    ```json
    {
      "appId": "",
      "displayName": "sp-admin-dev-app",
      "password": "",
      "tenant": ""
    }
    ```
- Crear variables de entorno que usara Terraform (Azure)
  - $env:ARM_CLIENT_ID = "appId"
  - $env:ARM_CLIENT_SECRET = "password"
  - $env:ARM_SUBSCRIPTION_ID = "subscription"
  - $env:ARM_TENANT_ID = "tenant"
  
