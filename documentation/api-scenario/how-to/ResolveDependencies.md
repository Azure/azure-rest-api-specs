# Resolve external dependencies

## Background

In some cases, we need to do more complex operations in some scenarios, like provisioning cross-RP resources as dependencies, calling cross-RP REST API in between the steps of a scenario, or executing some customized PowerShell/Azure CLI scripts. Some concrete examples are:

- Provisioning virtual network with subnet/publicIP/securityGroup and network interface with Network RP before creating a VM with Compute RP.
- Creating a private endpoint connection with Network RP between creating AppConfiguration configuration stores and calling its private endpoint related REST APIs.
- Uploading a jar file to some storage blob after creating a Spring Cloud service with AppPlatform RP.

To support these complex scenarios, we introduce two key features in API Scenario:

- External operation reference in step definition: We support referencing external operations in step definition, which can be used to call cross-RP REST API before a scenario or in between the steps of a scenario.
- ARM Template integration: We support creating external Azure resources with ARM Template and executing Azure Powershell or Azure CLI scripts with ARM Template deployment script.

## Examples

Here is an example about how to create a VM with API Scenario.

### With external operation reference

In operation based step, we can use property `readmeTag` to specify the external operation reference. In following example, `VirtualNetworks_CreateOrUpdate`, `NetworkSecurityGroups_CreateOrUpdate`, `PublicIPAddresses_CreateOrUpdate`, and `NetworkInterfaces_CreateOrUpdate` are external operations from Network RP, and the outputted variable `vmNicId` is referenced in `VirtualMachines_CreateOrUpdate` step when creating a VM.

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/documentation/api-scenario/references/v1.2/schema.json
scope: ResourceGroup

variables:
  vmName:
    type: string
    prefix: test
  adminPassword:
    type: secureString

prepareSteps:
  - step: createVirtualNetwork
    operationId: VirtualNetworks_CreateOrUpdate
    readmeTag: ../../../../../../network/resource-manager/readme.md#package-2021-05
    parameters:
      virtualNetworkName: $(vmName)-VNET
      parameters:
        location: $(location)
        properties:
          addressSpace:
            addressPrefixes:
              - 10.0.0.0/16
          subnets:
            - name: $(vmName)-Subnet
              properties:
                addressPrefix: 10.0.0.0/24
    outputVariables:
      subnetId:
        type: string
        fromResponse: /properties/subnets/0/id
  - step: createNSG
    operationId: NetworkSecurityGroups_CreateOrUpdate
    readmeTag: ../../../../../../network/resource-manager/readme.md#package-2021-05
    parameters:
      networkSecurityGroupName: $(vmName)-NSG
      parameters:
        location: $(location)
        properties:
          securityRules:
            - name: rdp
              properties:
                protocol: Tcp
                sourcePortRange: "*"
                destinationPortRange: "3389"
                sourceAddressPrefix: "*"
                destinationAddressPrefix: "*"
                access: Allow
                priority: 1000
                direction: Inbound
    outputVariables:
      networkSecurityGroupId:
        type: string
        fromResponse: /id
  - step: createPublicIP
    operationId: PublicIPAddresses_CreateOrUpdate
    readmeTag: ../../../../../../network/resource-manager/readme.md#package-2021-05
    parameters:
      publicIpAddressName: $(vmName)-PublicIP
      parameters:
        location: $(location)
        sku:
          name: Standard
        properties:
          publicIPAllocationMethod: Static
    outputVariables:
      publicIPAddressId:
        type: string
        fromResponse: /id
  - step: createNIC
    operationId: NetworkInterfaces_CreateOrUpdate
    readmeTag: ../../../../../../network/resource-manager/readme.md#package-2021-05
    parameters:
      networkInterfaceName: $(vmName)-VMNic
      parameters:
        location: $(location)
        properties:
          ipConfigurations:
            - name: ipconfig-$(vmName)
              properties:
                privateIPAllocationMethod: Dynamic
                subnet:
                  id: $(subnetId)
                publicIpAddress:
                  id: $(publicIPAddressId)
          networkSecurityGroup:
            id: $(networkSecurityGroupId)
    outputVariables:
      vmNicId:
        type: string
        fromResponse: /id

scenarios:
  - scenario: VirtualMachineScenario
    steps:
      - step: createVM
        operationId: VirtualMachines_CreateOrUpdate
        parameters:
          parameters:
            location: $(location)
            properties:
              hardwareProfile:
                vmSize: Standard_A2_v2
              networkProfile:
                networkInterfaces:
                  - id: $(vmNicId)
              storageProfile:
                osDisk:
                  createOption: fromImage
                  caching: ReadWrite
                imageReference:
                  publisher: MicrosoftWindowsServer
                  offer: WindowsServer
                  sku: 2019-Datacenter
                  version: latest
              osProfile:
                computerName: $(vmName)
                adminUsername: azureuser
                adminPassword: $(adminPassword)
              additionalCapabilities: {}
      - step: getVM
        operationId: VirtualMachines_Get

```

### With ARM Template

Besides external operation reference, we can also use ARM Template to provision resources. We first create an ARM Template file to provision virtual network, network security group, public IP, and network interface:
```json
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "vmName": {
      "type": "string",
      "defaultValue": "test"
    }
  },
  "variables": {
    "VNETName": "[concat(parameters('vmName'), '-VNET')]",
    "SubnetName": "[concat(parameters('vmName'), '-Subnet')]",
    "NSGName": "[concat(parameters('vmName'), '-NSG')]",
    "PublicIPName": "[concat(parameters('vmName'), '-PublicIP')]",
    "VMNicName": "[concat(parameters('vmName'), '-VMNic')]"
  },
  "resources": [
    {
      "name": "[variables('VNETName')]",
      "type": "Microsoft.Network/virtualNetworks",
      "location": "[resourceGroup().location]",
      "apiVersion": "2015-06-15",
      "dependsOn": [],
      "tags": {},
      "properties": {
        "addressSpace": {
          "addressPrefixes": [
            "10.0.0.0/16"
          ]
        },
        "subnets": [
          {
            "name": "[variables('SubnetName')]",
            "properties": {
              "addressPrefix": "10.0.0.0/24"
            }
          }
        ]
      }
    },
    {
      "name": "[variables('NSGName')]",
      "type": "Microsoft.Network/networkSecurityGroups",
      "apiVersion": "2015-06-15",
      "location": "[resourceGroup().location]",
      "tags": {},
      "dependsOn": [],
      "properties": {
        "securityRules": [
          {
            "name": "rdp",
            "properties": {
              "protocol": "Tcp",
              "sourcePortRange": "*",
              "destinationPortRange": "3389",
              "sourceAddressPrefix": "*",
              "destinationAddressPrefix": "*",
              "access": "Allow",
              "priority": 1000,
              "direction": "Inbound"
            }
          }
        ]
      }
    },
    {
      "name": "[variables('PublicIPName')]",
      "apiVersion": "2018-01-01",
      "type": "Microsoft.Network/publicIPAddresses",
      "location": "[resourceGroup().location]",
      "tags": {},
      "dependsOn": [],
      "properties": {
        "publicIPAllocationMethod": "Static"
      },
      "sku": {
        "name": "Standard"
      }
    },
    {
      "name": "[variables('VMNicName')]",
      "apiVersion": "2015-06-15",
      "type": "Microsoft.Network/networkInterfaces",
      "location": "[resourceGroup().location]",
      "tags": {},
      "dependsOn": [
        "[concat('Microsoft.Network/virtualNetworks/', variables('VNETName'))]",
        "[concat('Microsoft.Network/networkSecurityGroups/', variables('NSGName'))]",
        "[concat('Microsoft.Network/publicIPAddresses/', variables('PublicIPName'))]"
      ],
      "properties": {
        "ipConfigurations": [
          {
            "name": "ipconfigmyVM",
            "properties": {
              "privateIPAllocationMethod": "Dynamic",
              "subnet": {
                "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', variables('VNETName'), variables('SubnetName'))]"
              },
              "publicIPAddress": {
                "id": "[resourceId('Microsoft.Network/publicIPAddresses', variables('PublicIPName'))]"
              }
            }
          }
        ],
        "networkSecurityGroup": {
          "id": "[resourceId('Microsoft.Network/networkSecurityGroups', variables('NSGName'))]"
        }
      }
    }
  ],
  "outputs": {
    "vmNicId": {
      "type": "string",
      "value": "[resourceId('Microsoft.Network/networkInterfaces', variables('VMNicName'))]"
    }
  }
}

```

Then in `prepareSteps`, we can add a step to deploy the ARM Template:

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/documentation/api-scenario/references/v1.2/schema.json
scope: ResourceGroup

variables:
  vmName: test
  adminPassword:
    type: secureString

prepareSteps:
  - step: createDeps
    armTemplate: ./templates/deps.json

scenarios:
  - scenario: VirtualMachineScenario
    steps:
      - step: createVM
        operationId: VirtualMachines_CreateOrUpdate
        parameters:
          parameters:
            location: $(location)
            properties:
              hardwareProfile:
                vmSize: Standard_A2_v2
              networkProfile:
                networkInterfaces:
                  - id: $(vmNicId)
              storageProfile:
                osDisk:
                  createOption: fromImage
                  caching: ReadWrite
                imageReference:
                  publisher: MicrosoftWindowsServer
                  offer: WindowsServer
                  sku: 2019-Datacenter
                  version: latest
              osProfile:
                computerName: $(vmName)
                adminUsername: azureuser
                adminPassword: $(adminPassword)
              additionalCapabilities: {}

```

### ARM Template Deployment Script 

ARM Template Deployment Script is supported in API Scenario, so that some complex operations with Azure PowerShell or CLI script can be performed in a single step. Refer to [ARM Template Deployment Script documentation](https://learn.microsoft.com/azure/azure-resource-manager/templates/deployment-script-template).
