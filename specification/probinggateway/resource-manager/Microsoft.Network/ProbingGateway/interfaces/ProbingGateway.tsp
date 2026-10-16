import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "../models/ProbingGatewayModels.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.Network;

@@doc(ProbingGateway.name, "The name of the Probing Gateway.");
@@doc(ProbingGateway.properties, "The properties of the Probing Gateway.");
@doc("Class representing a Probing Gateway.")
model ProbingGateway is TrackedResource<ProbingGatewayProperties> {
  ...ResourceNameParameter<ProbingGateway>;
}

@@doc(
  ProbingGateways.createOrUpdate::parameters.resource,
  "The Probing Gateway parameters supplied to the CreateOrUpdate operation."
);
@armResourceOperations
interface ProbingGateways {
  @opExample(
    #{
      parameters: #{
        subscriptionId: "00000000-0000-0000-0000-000000000000",
        resourceGroupName: "rg1",
        probingGatewayName: "pg1",
        apiVersion: "2026-02-09-preview",
        provider: "Microsoft.Network",
      },
      returnType: #{
        statusCode: 200,
        body: #{
          name: "pg1",
          id: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/probingGateways/pg1",
          location: "eastus",
          properties: #{
            subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
            ipConfigurations: #[
              #{
                privateIpV4Address: "10.0.0.4",
                privateIpAllocationMethod: "Static",
              }
            ],
            provisioningState: "Succeeded",
          },
        },
      },
    },
    #{ title: "ProbingGateways_Get" }
  )
  @doc("Gets a Probing Gateway.")
  get is ArmResourceRead<ProbingGateway>;

  @opExample(
    #{
      parameters: #{
        subscriptionId: "00000000-0000-0000-0000-000000000000",
        resourceGroupName: "rg1",
        probingGatewayName: "pg1",
        apiVersion: "2026-02-09-preview",
        provider: "Microsoft.Network",
        resource: #{
          name: "pg1",
          location: "eastus",
          properties: #{
            subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
            ipConfigurations: #[
              #{
                privateIpV4Address: "10.0.0.4",
                privateIpAllocationMethod: "Static",
              }
            ],
          },
        },
      },
      returnType: #{
        statusCode: 200,
        body: #{
          name: "pg1",
          id: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/probingGateways/pg1",
          location: "eastus",
          properties: #{
            subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
            ipConfigurations: #[
              #{
                privateIpV4Address: "10.0.0.4",
                privateIpAllocationMethod: "Static",
              }
            ],
            provisioningState: "Succeeded",
          },
        },
      },
    },
    #{ title: "ProbingGateways_CreateOrUpdate" }
  )
  @doc("Create or update a Probing Gateway.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ProbingGateway>;

  @opExample(
    #{
      parameters: #{
        subscriptionId: "00000000-0000-0000-0000-000000000000",
        resourceGroupName: "rg1",
        probingGatewayName: "pg1",
        apiVersion: "2026-02-09-preview",
        provider: "Microsoft.Network",
      },
      returnType: #{ statusCode: 202 },
    },
    #{ title: "ProbingGateways_Delete" }
  )
  @doc("Deletes a Probing Gateway.")
  delete is ArmResourceDeleteWithoutOkAsync<ProbingGateway>;

  @opExample(
    #{
      parameters: #{
        subscriptionId: "00000000-0000-0000-0000-000000000000",
        resourceGroupName: "rg1",
        probingGatewayName: "pg1",
        apiVersion: "2026-02-09-preview",
        provider: "Microsoft.Network",
        properties: #{
          properties: #{
            subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
            ipConfigurations: #[
              #{
                privateIpV4Address: "10.0.0.5",
                privateIpAllocationMethod: "Static",
              }
            ],
          },
        },
      },
      returnType: #{
        statusCode: 200,
        body: #{
          name: "pg1",
          id: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/probingGateways/pg1",
          location: "eastus",
          properties: #{
            subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
            ipConfigurations: #[
              #{
                privateIpV4Address: "10.0.0.5",
                privateIpAllocationMethod: "Static",
              }
            ],
            provisioningState: "Succeeded",
          },
        },
      },
    },
    #{ title: "ProbingGateways_Patch" }
  )
  @doc("Updates a Probing Gateway.")
  patch is ArmCustomPatchAsync<
    ProbingGateway,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ProbingGateway,
      ProbingGatewayProperties
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
              name: "pg1",
              id: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/probingGateways/pg1",
              location: "eastus",
              properties: #{
                subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
                ipConfigurations: #[
                  #{
                    privateIpV4Address: "10.0.0.4",
                    privateIpAllocationMethod: "Static",
                  }
                ],
              },
            }
          ],
        },
      },
    },
    #{ title: "ProbingGateways_ListByResourceGroup" }
  )
  @doc("Lists all Probing Gateways within a resource group.")
  listByResourceGroup is ArmResourceListByParent<ProbingGateway>;

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
              id: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/probingGateways/pg1",
              location: "eastus",
              properties: #{
                subnetId: "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1/subnets/subnet1",
                ipConfigurations: #[
                  #{
                    privateIpV4Address: "10.0.0.4",
                    privateIpAllocationMethod: "Static",
                  }
                ],
              },
            }
          ],
        },
      },
    },
    #{ title: "ProbingGateways_ListBySubscription" }
  )
  @doc("Lists all Probing Gateways within a subscription.")
  listBySubscription is ArmListBySubscription<ProbingGateway>;

  @opExample(
    #{
      parameters: #{
        subscriptionId: "00000000-0000-0000-0000-000000000000",
        resourceGroupName: "rg1",
        probingGatewayName: "pg1",
        apiVersion: "2026-02-09-preview",
        provider: "Microsoft.Network",
        body: #{
          eventType: "Linked",
          topologyMapId: "00000000-0000-0000-0000-000000000001",
          siteId: "site-west-us",
          eventTimestamp: utcDateTime.fromISO("2026-02-10T00:00:00Z"),
        },
      },
      returnType: #{ statusCode: 204 },
    },
    #{ title: "ProbingGateways_CreateTopologyReference" }
  )
  @doc("Notifies the Probing Gateway of a topology reference link or unlink event.")
  @action("topologyReferences")
  createTopologyReference is ArmResourceActionNoContentSync<
    ProbingGateway,
    ProbingGatewayTopologyReferenceRequest
  >;
}
