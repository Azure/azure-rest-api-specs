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
@doc("Class representing an Azure Service Connection Controller.")
model AzureServiceConnectionController
  is TrackedResource<AzureServiceConnectionControllerProperties> {
  ...ResourceNameParameter<
    Resource = AzureServiceConnectionController,
    KeyName = "azureServiceConnectionControllerName",
    SegmentName = "azureServiceConnectionControllers"
  >;
  ...ManagedByProperty;
}

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
        azureServiceConnectionControllerName: "po1",
        apiVersion: "2026-02-09-preview",
        provider: "Microsoft.Network",
      },
      returnType: #{
        statusCode: 200,
        body: #{
          name: "po1",
          id: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/azureServiceConnectionControllers/po1",
          location: "eastus",
          properties: #{
            subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
            ipConfigurations: #[#{ privateIpV4Address: "10.0.0.10" }],
            providerConnections: #[
              #{
                name: "conn1",
                subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet2",
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
        azureServiceConnectionControllerName: "po1",
        apiVersion: "2026-02-09-preview",
        provider: "Microsoft.Network",
        resource: #{
          name: "po1",
          location: "eastus",
          properties: #{
            subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
            ipConfigurations: #[#{ privateIpV4Address: "10.0.0.10" }],
            providerConnections: #[
              #{
                name: "conn1",
                subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet2",
              }
            ],
          },
        },
      },
      returnType: #{
        statusCode: 200,
        body: #{
          name: "po1",
          id: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/azureServiceConnectionControllers/po1",
          location: "eastus",
          properties: #{
            subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
            ipConfigurations: #[#{ privateIpV4Address: "10.0.0.10" }],
            providerConnections: #[
              #{
                name: "conn1",
                subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet2",
              }
            ],
            provisioningState: "Succeeded",
          },
        },
      },
    },
    #{ title: "AzureServiceConnectionControllers_CreateOrUpdate" }
  )
  @doc("Create or update an Azure Service Connection Controller.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AzureServiceConnectionController>;

  @opExample(
    #{
      parameters: #{
        subscriptionId: "00000000-0000-0000-0000-000000000000",
        resourceGroupName: "rg1",
        azureServiceConnectionControllerName: "po1",
        apiVersion: "2026-02-09-preview",
        provider: "Microsoft.Network",
      },
      returnType: #{ statusCode: 202 },
    },
    #{ title: "AzureServiceConnectionControllers_Delete" }
  )
  @doc("Deletes an Azure Service Connection Controller.")
  delete is ArmResourceDeleteWithoutOkAsync<AzureServiceConnectionController>;

  @opExample(
    #{
      parameters: #{
        subscriptionId: "00000000-0000-0000-0000-000000000000",
        resourceGroupName: "rg1",
        azureServiceConnectionControllerName: "po1",
        apiVersion: "2026-02-09-preview",
        provider: "Microsoft.Network",
        properties: #{
          properties: #{
            providerConnections: #[
              #{
                name: "conn1",
                ipConfiguration: #{ privateIpV4Address: "10.0.0.11" },
              }
            ],
          },
        },
      },
      returnType: #{
        statusCode: 200,
        body: #{
          name: "po1",
          id: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/azureServiceConnectionControllers/po1",
          location: "eastus",
          properties: #{
            subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
            providerConnections: #[
              #{
                name: "conn1",
                ipConfiguration: #{ privateIpV4Address: "10.0.0.11" },
              }
            ],
            provisioningState: "Succeeded",
          },
        },
      },
    },
    #{ title: "AzureServiceConnectionControllers_Patch" }
  )
  @doc("Updates an Azure Service Connection Controller.")
  patch is ArmCustomPatchAsync<
    AzureServiceConnectionController,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AzureServiceConnectionController,
      AzureServiceConnectionControllerProperties
    >
  >;

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
              name: "po1",
              id: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/azureServiceConnectionControllers/po1",
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
              name: "po1",
              id: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/azureServiceConnectionControllers/po1",
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
