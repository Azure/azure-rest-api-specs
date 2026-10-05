import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/http";
import "@typespec/rest";
import "../models/AzureServiceConnectionControllerModels.tsp";

using Azure.ResourceManager;

namespace Microsoft.Network;

@@doc(
  AzureServiceConnectionController.name,
  "The name of the Azure Service Connection Controller."
);
@@doc(
  AzureServiceConnectionController.properties,
  "The properties of the Azure Service Connection Controller."
);
@doc("An Azure Service Connection Controller owned by its Probing Gateway. Direct customer PUT and DELETE requests are denied; deleting its gateway deletes the controller and its managed resources. Only tags can be updated directly.")
model AzureServiceConnectionController
  is TrackedResource<AzureServiceConnectionControllerProperties> {
  ...ResourceNameParameter<
    Resource = AzureServiceConnectionController,
    KeyName = "azureServiceConnectionControllerName",
    SegmentName = "azureServiceConnectionControllers"
  >;
  ...ManagedByProperty;
}

@@visibility(
  AzureServiceConnectionController.managedBy,
  Lifecycle.Read,
  Lifecycle.Create
);

@@doc(
  AzureServiceConnectionControllers.createOrUpdate::parameters.resource,
  "The Azure Service Connection Controller parameters supplied to the CreateOrUpdate operation."
);
@armResourceOperations
interface AzureServiceConnectionControllers {
  @opExample(
    #{
      parameters: #{
        subscriptionId: "00000000-0000-0000-0000-000000000000",
        resourceGroupName: "rg1",
        azureServiceConnectionControllerName: "pg1",
        apiVersion: "2026-02-09-preview",
        provider: "Microsoft.Network",
      },
      returnType: #{
        statusCode: 200,
        body: #{
          name: "pg1",
          id: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/azureServiceConnectionControllers/pg1",
          location: "eastus",
          managedBy: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/probingGateways/pg1",
          properties: #{
            subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
            ipConfigurations: #[
              #{ privateIpV4Address: "10.0.0.10", ipAllocationMethod: "Static" }
            ],
            providerConnections: #[
              #{
                name: "provider-connection",
                subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet2",
                privateEndpointResourceGroupName: "pe-rg1",
              }
            ],
            provisioningState: "Succeeded",
          },
        },
      },
    },
    #{ title: "AzureServiceConnectionControllers_Get" }
  )
  @doc("Gets an Azure Service Connection Controller.")
  get is ArmResourceRead<AzureServiceConnectionController>;

  @opExample(
    #{
      parameters: #{
        subscriptionId: "00000000-0000-0000-0000-000000000000",
        resourceGroupName: "rg1",
        azureServiceConnectionControllerName: "pg1",
        apiVersion: "2026-02-09-preview",
        provider: "Microsoft.Network",
        resource: #{
          name: "pg1",
          location: "eastus",
          managedBy: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/probingGateways/pg1",
          properties: #{
            subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
            ipConfigurations: #[
              #{ privateIpV4Address: "10.0.0.10", ipAllocationMethod: "Static" }
            ],
            providerConnections: #[
              #{
                name: "provider-connection",
                ipConfiguration: #{
                  privateIpV4Address: "10.0.0.11",
                  ipAllocationMethod: "Static",
                },
                subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet2",
                privateEndpointResourceGroupName: "pe-rg1",
              }
            ],
          },
        },
      },
      returnType: #{
        statusCode: 200,
        body: #{
          name: "pg1",
          id: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/azureServiceConnectionControllers/pg1",
          location: "eastus",
          managedBy: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/probingGateways/pg1",
          properties: #{
            subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
            ipConfigurations: #[
              #{ privateIpV4Address: "10.0.0.10", ipAllocationMethod: "Static" }
            ],
            providerConnections: #[
              #{
                name: "provider-connection",
                subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet2",
                privateEndpointResourceGroupName: "pe-rg1",
              }
            ],
            provisioningState: "Succeeded",
          },
        },
      },
    },
    #{ title: "AzureServiceConnectionControllers_CreateOrUpdate" }
  )
  @doc("Creates or updates an Azure Service Connection Controller.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AzureServiceConnectionController>;

  @opExample(
    #{
      parameters: #{
        subscriptionId: "00000000-0000-0000-0000-000000000000",
        resourceGroupName: "rg1",
        azureServiceConnectionControllerName: "pg1",
        apiVersion: "2026-02-09-preview",
        provider: "Microsoft.Network",
      },
      returnType: #{ statusCode: 202 },
    },
    #{ title: "AzureServiceConnectionControllers_Delete" }
  )
  @doc("Deletes an Azure Service Connection Controller. Only its owning Probing Gateway may call this operation.")
  delete is ArmResourceDeleteWithoutOkAsync<AzureServiceConnectionController>;

  @doc("Updates the tags of an Azure Service Connection Controller.")
  update is ArmTagsPatchSync<AzureServiceConnectionController>;

  @opExample(
    #{
      parameters: #{
        subscriptionId: "00000000-0000-0000-0000-000000000000",
        resourceGroupName: "rg1",
        apiVersion: "2026-02-09-preview",
        provider: "Microsoft.Network",
      },
      returnType: #{
        statusCode: 200,
        body: #{
          value: #[
            #{
              name: "pg1",
              id: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/azureServiceConnectionControllers/pg1",
              location: "eastus",
              properties: #{
                subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
              },
            }
          ],
        },
      },
    },
    #{ title: "AzureServiceConnectionControllers_ListByResourceGroup" }
  )
  @doc("Lists all Azure Service Connection Controllers within a resource group.")
  listByResourceGroup is ArmResourceListByParent<AzureServiceConnectionController>;

  @opExample(
    #{
      parameters: #{
        subscriptionId: "00000000-0000-0000-0000-000000000000",
        apiVersion: "2026-02-09-preview",
        provider: "Microsoft.Network",
      },
      returnType: #{
        statusCode: 200,
        body: #{
          value: #[
            #{
              name: "pg1",
              id: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/azureServiceConnectionControllers/pg1",
              location: "eastus",
              properties: #{
                subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
              },
            }
          ],
        },
      },
    },
    #{ title: "AzureServiceConnectionControllers_ListBySubscription" }
  )
  @doc("Lists all Azure Service Connection Controllers within a subscription.")
  listBySubscription is ArmListBySubscription<AzureServiceConnectionController>;
}
